Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A9AC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6444720862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UNGyNJNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfJCTcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:32:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:39939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731401AbfJCTcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570131113;
        bh=RsYW1tMQhVxSymVlEwGdBTZwMm3ZvLd9uaMyWMV0vz0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UNGyNJNeHfCx0k5lM+snCmDHFOZUU+nGO08Jh4E7eYCrsVXlTAI4bh3+NnbwWQsYQ
         b/rxTff9qTHfmK2nI13TS78wm12BAN+kM8u7Wirb//wCPhUmBWomiSQeZXAPp9vvVe
         i7Igv7cXyBHOy1ft6OHSJvs8k038RC8FVswqMbmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.25.131]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1iUcVg0bmf-00Pf1D; Thu, 03
 Oct 2019 21:31:53 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: Fix references to usb-hcd.yaml
Date:   Thu,  3 Oct 2019 21:31:32 +0200
Message-Id: <20191003193132.17758-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M1Cfub0cD8k5EWKPSmYJTQTfT0r5TxH1kizM8MObV5ouKOLtROW
 Y6Ve8LeMLt58u942N7DVrT7n9xh3Ro+vHN+He3rDjffEFt9acuMdP2CaSEXMNkf57Qn9TYS
 55iJdWnmjNPcLrCVWjQcV8Eh6ynBgXl+1OW+ZUZrq6re9aJVoe6EV36RHPoEoLO5WJPiRBb
 JtOOuApOnXnCR12OfgPLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K139XvLUorM=:UC2svAclllxusezgtqx7aj
 OQIMOkW9Yx52Cldj7c9AyhGNOkd4nddtd/qLQwHYhZ1CuDakZlc7LjgX1JD6CLdVuvlJRXInX
 ZT1c5ncYj4HaPvZoLZCbgO9ZCwz1qcp0/NTkjulPw0dTqfAdeT8K9tIkmQuprYGFbnW9kMEFk
 1c4QV3D9sKYmVH2KqadNCJc1rw2ARIQRsk2e/CoiAjgwRLiyeYH04S0FlreAKn3icTc2qzV7k
 oYF8ucnwIAdhc9o81jnE5zuxIP2VMy7655mtWfh7GqxtWJ2RNRR4ZViHPzAHjdz+2my76c1Yo
 9DTgPfvoWYIQJp6IJvzs9pn3FnwyKB0ibxEAZfUM7K+jsci2V/ckg+v9PRIz0MTaJMFNSdg1V
 flkR6Okr8vZEEHqdWD2opuVm7Jo2f1qjvPTvDY1YdBy+y6rL+giFEkx+NulDPPPqMRFNF/c+x
 S159BYfGpOxPSq/VcqzV1u91xNp4wJo/nMKHoyVF2IAyQ4O+/r3GPsABzFI15dqcw+YwCBTA1
 ZLRDQK3K/s5SfyQAfS25cmIWwhBbjnv+7gOLmtDCRo7EgS2gMOeAClMVyX9ptz/rw5s7pwtle
 1MQlwv3qK3dqfPsDIe8Q8rtA3JwYbZQ6GsdJD6ZwQmkZ7FNTq//s6zDTwOdodKzpfQLRsVss5
 FzoYqgBNMT3LHCXWVCr2CuRQD+L5Gxrlzxt6yda4vQPP0wL3i6VIENTNInShBXhudRoLODm8I
 4s339OIHrw6nVIKkDfOD0eYnVrgssn3li6j1b2k7JbUZKfW6tTn72g0oBKmUSR5LZs8xfeptL
 SwLZF2JfnAcmtLKj5lAtXWpSsq7PtmxN74rLbCFgDTouLmIcW4c7fJImwiwWdjwC+0Sr+7TGw
 Bh3DBLYk+c2JlwigKP3IfpAM03wAVG+ENRhDAVVkw5JV+wFnVJu+6pHNreC5ztaOah86qaEKv
 fXIQ3wlllKZhflxBHbdiarQc/Bdj4Rumiz/mN1ElqMGJHjZrtWtEH1OZDnPSiG0glJQKtg1Hk
 C9J6tgurj+KK1Dxtx110JV/c5ZZIoF9vsg7cKzEm7t4y2uA+CsN1rHsmL55L38z5UBLhw+OK5
 hbGFSGshNBGXYNPpmFAiGRftBMcPVyvWr11mrpQRmUvECKnjMSlwusjr9HTDof2DAOULLLrtV
 YGxUhG163JZkeAZ/OMJ5zk/EFA2AaWgLAzfAdrsTDly40glEiSu08S4tvb/AfypvBTh5p0q98
 9ynbT0qOnrogEiG4xqmKRv5G58ez0e+DSlvdzJ0qkCssv4Ht6EzLoJ6QYuRM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb-hcd.txt has been converted to YAML. Update references accordingly.

Fixes: 14ec072a19ad ("dt-bindings: usb: Convert USB HCD generic binding to=
 YAML")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 4 ++--
 Documentation/devicetree/bindings/usb/mediatek,mtu3.txt     | 4 ++--
 Documentation/devicetree/bindings/usb/usb-uhci.txt          | 2 +-
 Documentation/devicetree/bindings/usb/usb-xhci.txt          | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b=
/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index f3e4acecabe8..42d8814f903a 100644
=2D-- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -33,7 +33,7 @@ Required properties:
 	"dma_ck": dma_bus clock for data transfer by DMA,
 	"xhci_ck": controller clock

- - phys : see usb-hcd.txt in the current directory
+ - phys : see usb-hcd.yaml in the current directory

 Optional properties:
  - wakeup-source : enable USB remote wakeup;
@@ -53,7 +53,7 @@ Optional properties:
 	See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
  - imod-interval-ns: default interrupt moderation interval is 5000ns

-additionally the properties from usb-hcd.txt (in the current directory) a=
re
+additionally the properties from usb-hcd.yaml (in the current directory) =
are
 supported.

 Example:
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Doc=
umentation/devicetree/bindings/usb/mediatek,mtu3.txt
index b9af7f5ee91d..e0ae6096f7ac 100644
=2D-- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -17,7 +17,7 @@ Required properties:
  - clock-names : must contain "sys_ck" for clock of controller,
 	the following clocks are optional:
 	"ref_ck", "mcu_ck" and "dma_ck";
- - phys : see usb-hcd.txt in the current directory
+ - phys : see usb-hcd.yaml in the current directory
  - dr_mode : should be one of "host", "peripheral" or "otg",
 	refer to usb/generic.txt

@@ -60,7 +60,7 @@ Optional properties:
  - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
 	bit1 for u3port1, ... etc;

-additionally the properties from usb-hcd.txt (in the current directory) a=
re
+additionally the properties from usb-hcd.yaml (in the current directory) =
are
 supported.

 Sub-nodes:
diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.txt b/Document=
ation/devicetree/bindings/usb/usb-uhci.txt
index cc2e6f7d602e..d1702eb2c8bd 100644
=2D-- a/Documentation/devicetree/bindings/usb/usb-uhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.txt
@@ -6,7 +6,7 @@ Required properties:
 - reg : Should contain 1 register ranges(address and length)
 - interrupts : UHCI controller interrupt

-additionally the properties from usb-hcd.txt (in the current directory) a=
re
+additionally the properties from usb-hcd.yaml (in the current directory) =
are
 supported.

 Example:
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Document=
ation/devicetree/bindings/usb/usb-xhci.txt
index 97400e8f8605..b49b819571f9 100644
=2D-- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -41,9 +41,9 @@ Optional properties:
   - usb3-lpm-capable: determines if platform is USB3 LPM capable
   - quirk-broken-port-ped: set if the controller has broken port disable =
mechanism
   - imod-interval-ns: default interrupt moderation interval is 5000ns
-  - phys : see usb-hcd.txt in the current directory
+  - phys : see usb-hcd.yaml in the current directory

-additionally the properties from usb-hcd.txt (in the current directory) a=
re
+additionally the properties from usb-hcd.yaml (in the current directory) =
are
 supported.


=2D-
2.20.1

