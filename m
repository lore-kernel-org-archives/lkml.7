Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB67C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E02206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519900;
	bh=4lpxXU2p3Hjyoh0K7wEvhHtrnxxSunMDGWN6OBThWKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bKFoBqywSAuuGT6Slhw1a+9Z9cMIPQyINQeH+GRmEdcA4jDYLs922lKA2nZ1Q6Rvz
	 URVoNTmJWgCGfrBmbzTH0tH4NB3PAKAxfXYBsPddksqL8mTPMR6UPJyDh+WP9BSuY9
	 LvwYuP1tARpMdjQs2TLAHzIjeTNhsk92l3wD6uCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfLPSLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730811AbfLPSLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:11:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7452072D;
        Mon, 16 Dec 2019 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519896;
        bh=4lpxXU2p3Hjyoh0K7wEvhHtrnxxSunMDGWN6OBThWKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kT2F1VyDy8/h2HN4sDtZRbMDcr1pd8pDCE1o+8tAR4nmqGSldePMI9eScLMd2g23E
         BMnMBqtRFp5oQ0wjS5fO379/INh0nIuWNk5LWF2DATvMMfAr0kYLAIC/yG5Q6xMiaf
         ApjHAlBLhG3ZmGEJUS/7j2eRTsytRmlZ3ojkoJmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Rasmussen <jacobraz@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.3 076/180] ASoC: rt5645: Fixed typo for buddy jack support.
Date:   Mon, 16 Dec 2019 18:48:36 +0100
Message-Id: <20191216174830.721910122@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Rasmussen <jacobraz@chromium.org>

commit fe23be2d85b05f561431d75acddec726ea807d2a upstream.

Had a typo in e7cfd867fd98 that resulted in buddy jack support not being
fixed.

Fixes: e7cfd867fd98 ("ASoC: rt5645: Fixed buddy jack support.")
Signed-off-by: Jacob Rasmussen <jacobraz@google.com>
Reviewed-by: Ross Zwisler <zwisler@google.com>
Cc: <jacobraz@google.com>
CC: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191114232011.165762-1-jacobraz@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/rt5645.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3271,7 +3271,7 @@ static void rt5645_jack_detect_work(stru
 				    report, SND_JACK_MICROPHONE);
 		return;
 	case 4:
-		val = snd_soc_component_read32(rt5645->component, RT5645_A_JD_CTRL1) & 0x002;
+		val = snd_soc_component_read32(rt5645->component, RT5645_A_JD_CTRL1) & 0x0020;
 		break;
 	default: /* read rt5645 jd1_1 status */
 		val = snd_soc_component_read32(rt5645->component, RT5645_INT_IRQ_ST) & 0x1000;


