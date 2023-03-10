// @generated by protoc-gen-es v1.0.0
// @generated from file greet/v1/service.proto (package greet.v1, syntax proto3)
/* eslint-disable */
// @ts-nocheck

import { proto3, Timestamp } from "@bufbuild/protobuf";

/**
 * @generated from message greet.v1.GreetMessage
 */
export const GreetMessage = proto3.makeMessageType(
  "greet.v1.GreetMessage",
  () => [
    { no: 1, name: "name", kind: "scalar", T: 9 /* ScalarType.STRING */ },
  ],
);

/**
 * @generated from message greet.v1.GreetResponse
 */
export const GreetResponse = proto3.makeMessageType(
  "greet.v1.GreetResponse",
  () => [
    { no: 1, name: "greeting", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 2, name: "timestamp", kind: "message", T: Timestamp },
  ],
);

