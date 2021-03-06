module Shapes  where

import Data.Map as Map
import Data.Maybe
import Text.Blaze.Svg11 as S
import Text.Blaze.Svg11.Attributes as SA

import Style

-- Shapes
data Shape = Circle 
           | Square
           | Empty
          deriving (Show,Read)

circle, square, empty :: Shape
empty = Shapes.Empty
square = Square
circle = Circle

-- Transformations
data Transform = Identity
               | Translate Double Double
               | Scale Double Double
               | Rotate Double
               | Compose Transform Transform
              deriving (Show,Read)

identity = Identity
translate = Translate
scale = Scale
rotate = Rotate
t0 <+> t1 = Compose t0 t1

-- Pattern macthes out the DSL, converting the info the relevant AttributeValue
transform :: Transform -> [AttributeValue]
transform (Translate x y) = [S.translate x y]
transform (Scale x y)     = [S.scale x y]
transform (Rotate a)      = [S.rotate a]
transform (Compose t0 t1) = (Shapes.transform t1) ++ (Shapes.transform t0)

-- Drawing
type Drawing = [(Transform,Shape,StyleTrans)]

