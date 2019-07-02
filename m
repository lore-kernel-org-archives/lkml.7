Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6355FC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43820645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dlagoiXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGBJlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:41:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:53567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGBJlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562060457;
        bh=oSqquuEE5yW/c8iRNBPSI0a5cJClK80fy7DvXrOLPr8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dlagoiXf/RIMZkio48bbIEFFdFxC0w4tvy9u6hAXvstcAOzImbjRJrfBMLaJQQjE4
         Me0c5R103Sxko8B/UHSsVYA+gNY5V7QLDnhnywvbhMXJDLET5oarLPP5RGoSjysDIy
         ogEmPVwoWfRZRDeT4GEToiRzNHubODIOQDqPP+GE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.147.59]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvsJ5-1iZW9u3D2l-00srKO; Tue, 02 Jul 2019 11:40:57 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Josef Friedl <josef.friedl@speed.at>
Subject: [PATCH 1/3] add doc and MAINTAINERS for poweroff
Date:   Tue,  2 Jul 2019 11:40:43 +0200
Message-Id: <20190702094045.3652-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702094045.3652-1-frank-w@public-files.de>
References: <20190702094045.3652-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:2vYhi+xH+hblnqvwu7JCJIYk+RNMfwzyTaHzeLF4uHhL2sVf5es
 na0tRbfWtiREIfkOSzpQ4pqdw/gGlzeayu5qhOw5et1M80TXvGZEna7ax/vbyqEADYZrk3I
 uq5s3VavjDAOv/uOqGtFkUrtx0r/Q8gKMTmYUxv9K9J3TRsEKgn1CQZBZTgrNenoS6P+7Xz
 ds35ih+ygouOf+FACkwEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6WGGfsOJ0Z4=:mmz9GFuTPxrR8oTzHF4LQw
 CMbl9OPIDv0qksIZOiZ3eL7KkLsw9FVgxEgHwbk89ceEldUeH06u46zg3fiVAF38PVn2j9DUV
 vIdBOkIm1CThm4Gl/39wVNKqWPTaTw2Woi4GuQbmeI6ga19v1Es5xTUUUP6qN2a3KDByYvegb
 if08rfhlVr14vdTUvxqCaVwbkiiov1h96hBeQw0Q80Z0Vy+8S1Q5QWA2H+kOnWZpmqs+ooOam
 9/iSqVmq4wVpe/FlNgFoD+eDUomNy/8MGvHV3DvWcKWgI8pQ3iZNcB9sQpxhODTfw7Qly65Xg
 eI6Vw1VYJQSYCtr9y3ZZwWgva02ifKkbqLytaaeIACYWJ7MOq6jj+qYMYdH7Esxa2pVCxbJLj
 mjfvECFG9CP88xWBhZ6A2SvMjejOVks0fgCfFUk4MOSx9CudyWOcJbfZyasz286pjiYoTgu0V
 D9K47G7F7njz2qdly9yhRWbE2i4DuPc4oVaOh6aCD9txp1RxCPbTd682aE5OH5+PzyomoSLNR
 pX7S/0L2Hg9EoBLAMuNywM86Z1tzXVTRP7hFAleAd7rHOcdSaUl9z6BM6Lkq1QEWenVLQwZZn
 DqrkDNAX5nGKGHaEPvdZnp+vi5O8BucZayu19nCpwaHvd5FY1aadKckFlK1APWb3vH5h+SMru
 ldLt9X0on9t26vJnMxB171/tIPcePmTBsgzC2dwL/sqeEQ35/f7oAh8waEftHyfJ5anHiHO5N
 YuudQBTHeo0tkG/Iat3DG/F1r6i80pdYXarq0InXE1KrEzqGAxryBT4jvaitvYfffOjxN1353
 9rDx7vBwnfPzIIoZ1GX2udhbpHF1Yyvv1ZBu31K672l9GkooGgNnQ8eCvFNQ9hg1uHm30MnDK
 O7UGBkCEWqqUFGrll+eUD6se43oX0E7R1wXY/7U2qNqu2UH+QfKtXaDOmNlsi1c1LMrLCaQZ8
 +0UtrAPpXPk91gM08YypkdQ6B/4SuW1MdeyhmNy0/9BuXiBDGTaDae9pZ3xdjO0xajX7mC3Dp
 4Nm74/NMrlkUSfqbFgTQ8Q94USrHpaXyTxaS8LeJ5kzOSvgA3Igov4arEtSdYcGSLBOHQjB9D
 Z1gmS9XtOQIas8=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

poweroff for BPI-R2
Suggested-by: Frank Wunderlich <frank-w@public-files.de>

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
=2D--
 .../devicetree/bindings/mfd/mt6397.txt        | 10 ++++++-
 .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt    | 29 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 4 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-p=
oweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentat=
ion/devicetree/bindings/mfd/mt6397.txt
index 0ebd08af777d..44acb9827716 100644
=2D-- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -8,6 +8,7 @@ MT6397/MT6323 is a multifunction device with the following=
 sub modules:
 - Clock
 - LED
 - Keys
+- Power controller

 It is interfaced to host controller using SPI interface by a proprietary =
hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwra=
p.
@@ -22,8 +23,10 @@ compatible: "mediatek,mt6397" or "mediatek,mt6323"
 Optional subnodes:

 - rtc
-	Required properties:
+	Required properties: Should be one of follows
+		- compatible: "mediatek,mt6323-rtc"
 		- compatible: "mediatek,mt6397-rtc"
+	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 - regulators
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
@@ -46,6 +49,11 @@ Optional subnodes:
 		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
 	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

+- power-controller
+	Required properties:
+		- compatible: "mediatek,mt6323-pwrc"
+	For details, see Documentation/devicetree/bindings/power/reset/mt6323-po=
weroff.txt
+
 Example:
 	pwrap: pwrap@1000f000 {
 		compatible =3D "mediatek,mt8135-pwrap";
diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff=
.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
new file mode 100644
index 000000000000..933f0c48e887
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
@@ -0,0 +1,20 @@
+Device Tree Bindings for Power Controller on MediaTek PMIC
+
+The power controller which could be found on PMIC is responsible for exte=
rnally
+powering off or on the remote MediaTek SoC through the circuit BBPU.
+
+Required properties:
+- compatible: Should be one of follows
+       "mediatek,mt6323-pwrc": for MT6323 PMIC
+
+Example:
+
+       pmic {
+               compatible =3D "mediatek,mt6323";
+
+               ...
+
+               power-controller {
+                       compatible =3D "mediatek,mt6323-pwrc";
+               };
+       }
diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Docume=
ntation/devicetree/bindings/rtc/rtc-mt6397.txt
new file mode 100644
index 000000000000..ebd1cf80dcc8
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for MediaTek PMIC based RTC
+
+MediaTek PMIC based RTC is an independent function of MediaTek PMIC that =
works
+as a type of multi-function device (MFD). The RTC can be configured and s=
et up
+with PMIC wrapper bus which is a common resource shared with the other
+functions found on the same PMIC.
+
+For MediaTek PMIC MFD bindings, see:
+Documentation/devicetree/bindings/mfd/mt6397.txt
+
+For MediaTek PMIC wrapper bus bindings, see:
+Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+
+Required properties:
+- compatible: Should be one of follows
+       "mediatek,mt6323-rtc": for MT6323 PMIC
+       "mediatek,mt6397-rtc": for MT6397 PMIC
+
+Example:
+
+       pmic {
+               compatible =3D "mediatek,mt6323";
+
+               ...
+
+               rtc {
+                       compatible =3D "mediatek,mt6323-rtc";
+               };
+       };
diff --git a/MAINTAINERS b/MAINTAINERS
index 01a52fc964da..ec6ff342aa3c 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9920,6 +9920,12 @@ S:	Maintained
 F:	drivers/net/dsa/mt7530.*
 F:	net/dsa/tag_mtk.c

+MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
+
 MEDIATEK JPEG DRIVER
 M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
=2D-
2.17.1

