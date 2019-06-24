Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A57C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F24208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370638;
	bh=wccXvejUM8tStnCnkBWeBJuealgTjoD8m0JC6Et+CAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=atj7np1TMxPd3+QBjdSMBIdjh520palXj8S8qWd5lWNxXRsAMUlWn85oyJw0g/U9z
	 /0cBwJGimpbWiYusJvLiVMKF029mWloB7dv4oaYFcbIepXrHJvSNubWK0rw7GLKzUB
	 V7E8dySz4C4/BOjq4B51YJrPHbytVehGt7jJYwIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfFXKD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbfFXKDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:03:54 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E3C208E3;
        Mon, 24 Jun 2019 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370634;
        bh=wccXvejUM8tStnCnkBWeBJuealgTjoD8m0JC6Et+CAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Da9kDXzaNLfkVj6J4mYh0fYjbITnF/zl6r7q7mv+fdTT7tuJrqoUTbInTWEY02NGF
         J0znzMw/2XMF2WFOaqFFwq3LwPAT7yzxT8AcixAPoH2OrGOTjmLiax21T8wZnTjXHG
         0eShzZSVzlapYN6J4eWlTWTqQH+rcNzNMz9inZkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/90] ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC node
Date:   Mon, 24 Jun 2019 17:56:24 +0800
Message-Id: <20190624092316.543669276@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4c70850aeb2e40016722cd1abd43c679666d3ca0 ]

Add the binding for RX/TX fifo size of GMAC node.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/boot/dts/hsdk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index f67f614ccb0e..d131c54acd3e 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -184,6 +184,9 @@
 			mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
 			dma-coherent;
 
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
+
 			mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.20.1



