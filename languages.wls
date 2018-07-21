#!/usr/bin/env wolframscript -cloud
(* Copyright 2018 Yoshihiro Tanaka *)
(* Licensed under the Apache License, Version 2.0 (the "License"); *)
(* you may not use this file except in compliance with the License. *)
(* You may obtain a copy of the License at *)

(*   http://www.apache.org/licenses/LICENSE-2.0 *)

(* Unless required by applicable law or agreed to in writing, software *)
(* distributed under the License is distributed on an "AS IS" BASIS, *)
(* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *)
(* See the License for the specific language governing permissions and *)
(* limitations under the License. *)

(* Author: Yoshihiro Tanaka <contact@cordea.jp> *)
(* date  : 2018-07-21 *)

linguistURL = "https://github.com/github/linguist/archive/master.zip"
ymlPath = "linguist-master/lib/linguist/languages.yml"

zip = URLDownload[linguistURL, FileNameJoin[{$TemporaryDirectory, "repo.zip"}]]
yml = Flatten[StringSplit[Import[ zip, {ymlPath, "Text"}], "\n"]]

positions = Flatten[Position[yml, _String?(StringMatchQ[#, RegularExpression["^[^#]\\w(\\w|\\s)+:$"]] &)]]
programmingLangPositions = Select[positions, StringMatchQ[yml[[#+1]], __ ~~ "programming"] &]

langs = StringDrop[yml[[programmingLangPositions]], -1]

Do[Print[x], {x, langs}]

(* Maybe, CloudDeploy is not allowed in Wolfram script. *)
(* CloudDeploy[APIFunction[{}, langs &]] *)
