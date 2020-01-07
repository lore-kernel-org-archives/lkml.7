Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85703C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486A72072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431247;
	bh=MuIb+sqGhjVYAmssrn+7TlscdFUuD8dmFEMaZbKcdMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZl3DZGL+ph03NF9yIT1beRJiuCEIit9px2Oi3BGrNJLBV2IZD+l2evtATALidyVF
	 OYYhilk8oCHR3+RyWve/7ZQAwlpxVW5IKKg+j99ptFmUN0mjJnwa4xVeJOpbkDeW7G
	 OCmFCsKo1/RyDyJvLXuOJuVCDnAfIiLdfxtGiSAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgAGVH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbgAGVHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D296208C4;
        Tue,  7 Jan 2020 21:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431240;
        bh=MuIb+sqGhjVYAmssrn+7TlscdFUuD8dmFEMaZbKcdMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toNsWI6bj148UelajbQ/17b9/feUH7Rdjt4u2cLmHzQlK2Hq+ljDri02T92oKXCQu
         5AwWKEkVWf/WV70lGY8LyUFOjQMQI82aDlpci/tUaVU5Npj17SxtTOC+FIf+rfhMjG
         QK8qBi/gABQ9+M+Oh0QO2b/1mK86FNAL7q6HZStA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.19 092/115] dt-bindings: clock: renesas: rcar-usb2-clock-sel: Fix typo in example
Date:   Tue,  7 Jan 2020 21:55:02 +0100
Message-Id: <20200107205306.862249723@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 830dbce7c76ea529decac7d23b808c1e7da3d891 upstream.

The documented compatible value for R-Car H3 is
"renesas,r8a7795-rcar-usb2-clock-sel", not
"renesas,r8a77950-rcar-usb2-clock-sel".

Fixes: 311accb64570db45 ("clk: renesas: rcar-usb2-clock-sel: Add R-Car USB 2.0 clock selector PHY")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191016145650.30003-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.txt
@@ -46,7 +46,7 @@ Required properties:
 Example (R-Car H3):
 
 	usb2_clksel: clock-controller@e6590630 {
-		compatible = "renesas,r8a77950-rcar-usb2-clock-sel",
+		compatible = "renesas,r8a7795-rcar-usb2-clock-sel",
 			     "renesas,rcar-gen3-usb2-clock-sel";
 		reg = <0 0xe6590630 0 0x02>;
 		clocks = <&cpg CPG_MOD 703>, <&usb_extal>, <&usb_xtal>;


