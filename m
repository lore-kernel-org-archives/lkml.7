Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116FBC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16002067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NX4ksi/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfD1PIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:08:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:55945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfD1PIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556464124;
        bh=gUWVEoixsLG8fS5GtjGTq/DKZWb25b3GZCWgkNzyOxM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NX4ksi/BP3OLFp+NJijtQGAkdmCx57/pXfVCK/GxY0ymkxeoav8+Knlwrdknlcpba
         KiznCxh6iC9dY1zk+50oGnKKBure7OV3dii8HvWrBHZmjLo6Kca0rzZhA7lLjwunnT
         fg0WYwIECTal2hvXqeoQapES+HhhNdYZVvq9b9cE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1goTOr1jvR-00f9U7; Sun, 28
 Apr 2019 17:08:44 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-msm@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: Fix spelling of bias-pull-up
Date:   Sun, 28 Apr 2019 17:08:22 +0200
Message-Id: <20190428150822.13935-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:om3F4mQ3swbdGmbNVM6rDweA4Mh+8ytRKWzoxYr4kjQ4IVbBw1Z
 /JoFOAS3mJYTW7Zq3IRV7wWqlZv0Vu9FoUqSZPP2YlT5wtv3vi5zcMzKmsmE092StJtfk4/
 do7lst5om/igGDCwMF+OmXMzGx7aYDqSuxC1vgMO4u+gHh0TQWBgSpbxAPAhgs/XFnxLmSV
 7i9DlD+00nzdu74ypPXdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vP8F8EZIwnM=:5qVSy49xY+1/UHCTLzZhon
 qSjliePUP+MaUojzqRV6glkmWyVW6W7Wdi6QJ4MWTTTJI7n/pCvSq5JAjNBNVmTcytX8RwKzn
 IxNMkHB6VsVmquwFpAU4kDUD4DX3bqoq0B5xDlRkGvHe7CexmtMtqyg0H6SDSvxIDo9nBDt8Z
 Q32Nl8VNs+N41RSwTEpOGdYNtoRJ5V73DuX9qImRODfeUJkuKEvrvcGy8VxlJt0x/LFzWd1d8
 pFIAZDGX4zcir9AFuQgl64MrmXKApzzSPfEXvD5YNwhZaWMXgazFTgpgZjnNuSUgAXYOF9aNF
 bNMB3VTYtsqb64i0p2wZTR//lidSmPJ6+flfTkl9ar5ibb+WBdQUJ8jun2e0FklYRA3Eib5Uv
 fixKW4NscuLsQMuDus6JwGRTw1IHRJ4mXqVKHcD2X0Wyr7BwAOOisflt/mfdSt40XKCK6Mk4S
 4++6kYJOkChujIJj6ogd8vrxpfNdXVOr4jIBs436wQ7q9RMb0OEH15Q7mbKLuIfVE+uOE91/F
 FS28Z9gPmcLYzz61KRsE91K2xgtCBxHWayLVd6q7HBClPZ6WJt6jRTPIyf3wVnCNiSoXTR1/X
 m1DqGO6IUCavpEJikSxO9qmcNvunAwCGdQhmecAIaa7rWAanx4VxeNcb8PoFOcEW6K6wwdrIO
 RovrYZVxGT6yPZAMUAYMQphrQg9zGBibnzik1mnE0Cntd9PrGS+QFcyELGNe03uujW1wEk66o
 mPdBQhbyFNK80nJZ519S4S0Z+hWm0G9TIOUdGmJE+5BN9AHAfIT+aVMq80MCA9qPtN/5GbC6Y
 tJpKC82nbW+oM0y+YC8Raa64CTucmVWhyMYF//0kaHzhL/+lXYhVv5GbLNLpTfvxc4HPLpfYN
 xV8K6T7ccGwZSQDYI0K7BciWiJAIpnBFAP9mq8G75Zz/JfabPpDxFnx/7EUNoTB3aVzqyuQ0Q
 Tt2izX6VwlQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property is spelled 'bias-pull-up', as documented in
pinctrl-bindings.txt.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctr=
l.txt b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
index c2dbb3e8d840..4e90ddd77784 100644
=2D-- a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
@@ -42,7 +42,7 @@ information about e.g. the mux function.
 The following generic properties as defined in pinctrl-bindings.txt are v=
alid
 to specify in a pin configuration subnode:

- pins, function, bias-disable, bias-pull-down, bias-pull,up, drive-streng=
th,
+ pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-streng=
th,
  output-low, output-high.

 Non-empty subnodes must specify the 'pins' property.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctr=
l.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
index 991be0cd0948..84be0f2c6f3b 100644
=2D-- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
@@ -44,7 +44,7 @@ information about e.g. the mux function.

 The following generic properties as defined in pinctrl-bindings.txt are v=
alid
 to specify in a pin configuration subnode:
- pins, function, bias-disable, bias-pull-down, bias-pull,up, drive-streng=
th.
+ pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-streng=
th.

 Non-empty subnodes must specify the 'pins' property.
 Note that not all properties are valid for all pins.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctr=
l.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
index 7ed56a1b70fc..a7aaaa7db83b 100644
=2D-- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
@@ -42,7 +42,7 @@ information about e.g. the mux function.
 The following generic properties as defined in pinctrl-bindings.txt are v=
alid
 to specify in a pin configuration subnode:

- pins, function, bias-disable, bias-pull-down, bias-pull,up, drive-streng=
th,
+ pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-streng=
th,
  output-low, output-high.

 Non-empty subnodes must specify the 'pins' property.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctr=
l.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
index cdc4787e59d2..f095209848c8 100644
=2D-- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
@@ -42,7 +42,7 @@ information about e.g. the mux function.
 The following generic properties as defined in pinctrl-bindings.txt are v=
alid
 to specify in a pin configuration subnode:

- pins, function, bias-disable, bias-pull-down, bias-pull,up, drive-streng=
th,
+ pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-streng=
th,
  output-low, output-high.

 Non-empty subnodes must specify the 'pins' property.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctr=
l.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
index c22e6c425d0b..004056506679 100644
=2D-- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
@@ -41,7 +41,7 @@ information about e.g. the mux function.

 The following generic properties as defined in pinctrl-bindings.txt are v=
alid
 to specify in a pin configuration subnode:
- pins, function, bias-disable, bias-pull-down, bias-pull,up, drive-streng=
th.
+ pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-streng=
th.

 Non-empty subnodes must specify the 'pins' property.
 Note that not all properties are valid for all pins.
=2D-
2.20.1

