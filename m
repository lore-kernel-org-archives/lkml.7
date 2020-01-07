Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F40CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C2C2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432137;
	bh=cqLQ1sbgU+vrRUMiMJlpuJO9wl/r6iZX6UVS87pB9uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rEej3whN6xW2wdZo2SBKncTEOFj97WyLzrYdAdimsAjU8yP3zzBpZleO00mTMOo/X
	 8g9J5X4JUBjeA0jq8ssXVZiZCXrdldl9r7+5CgNGtCnU/GTBvD65j/2xDV+gT0C/dO
	 baVe2wCX29nvWrCUN9z4S+D+8+9typFiR+Wfmw6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAGVWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbgAGVC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:02:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C182077B;
        Tue,  7 Jan 2020 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430947;
        bh=cqLQ1sbgU+vrRUMiMJlpuJO9wl/r6iZX6UVS87pB9uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZ0hZiGEKOXJPcp+n2AROUPCNfcLlIt0smgBXZ36ucaEBSNU210OLzDOlMl+Ut0Gh
         gzU+yyfdxWSCrocXk+MBmqmIwnb1QVrUwx8uYpPuMY9Nl3dAPw+9QTRnGeRWuuQ3OD
         88oqTUJv3No6OSmFr8Onkq/JUTIyUQIEgLhQ0uvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5.4 161/191] arm64: dts: meson-gxl-s905x-khadas-vim: fix uart_A bluetooth node
Date:   Tue,  7 Jan 2020 21:54:41 +0100
Message-Id: <20200107205341.602729402@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

commit 1c6d575574ec87dbccf7af20ef9dc0df02614069 upstream.

Fixes: dd5297cc8b8b ("arm64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -192,6 +192,9 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 


