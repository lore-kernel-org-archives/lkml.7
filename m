Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344EAC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B7D214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431048;
	bh=Gb3U+BDIxeNBJasnmv4gqizVlg4xZH5F5HJdwOqYW6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QhyoBysDxZiP3Gyfp9gr/kbvLcaHGxPt8zMH4+idq9gsCu5mjhgD9/kPxAPMqflm/
	 g7uEKNOc5Ma2U+MtaFrvu9Oa8uh3M98LTcsVpYa0aFrlMPtZYMbDJKlMSWwAvxl/Q1
	 afaW31nuK0YjzaOLEeBE2+3SmHwVBX6+Sx2qev08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgAGVEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:04:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbgAGVD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:03:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53178208C4;
        Tue,  7 Jan 2020 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431036;
        bh=Gb3U+BDIxeNBJasnmv4gqizVlg4xZH5F5HJdwOqYW6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2PfTRVqXEBOe1mBjGzZtUDHadjFNJoXkrOWdoCa7VRyj0vMgqm8/eDz8/e7i97BD
         iDMMrjk2WydRSwv55hF3nBq2jqxaw6R2BG6p4oxvfSFO0BSdjBsko1hdZbOfI24RoG
         /cFAx6U2nJIgDWHYFO94nGsAjITxiWipoK1wE5jE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5.4 162/191] arm64: dts: meson-gxm-khadas-vim2: fix uart_A bluetooth node
Date:   Tue,  7 Jan 2020 21:54:42 +0100
Message-Id: <20200107205341.655054153@linuxfoundation.org>
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

commit 388a2772979b625042524d8b91280616ab4ff5ee upstream.

Fixes: 33344e2111a3 ("arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -409,6 +409,9 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 


