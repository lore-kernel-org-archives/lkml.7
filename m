Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98258C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE3220818
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDHOem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:34:42 -0400
Received: from mail.delivery-51-eu-central-1.prod.hydra.sophos.com ([35.159.27.143]:57344
        "EHLO mail.delivery-51-eu-central-1.prod.hydra.sophos.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfDHOel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:34:41 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 10:34:40 EDT
Received: from mail.delivery-9-eu-central-1.prod.hydra.sophos.com (ip-172-20-0-105.eu-central-1.compute.internal [172.20.0.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.delivery-51-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id 44dCSh5BkHz9B2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 14:28:04 +0000 (UTC)
Received: from ip-172-20-1-157.eu-central-1.compute.internal (ip-172-20-1-157.eu-central-1.compute.internal [127.0.0.1])
        by mail.delivery-9-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTP id 44dCSg3TTfzgY8G;
        Mon,  8 Apr 2019 14:28:03 +0000 (UTC)
X-Sophos-Email-ID: 4614bc7ac1fb47f180ed3d5c4586770a
Received: from smtp.eckelmann.de (smtp.eckelmann.de [217.19.183.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 44dCSd4x19z5vM6; Mon,  8 Apr 2019 14:28:01 +0000 (UTC)
Received: from ws067.eckelmann.group (2a00:1f08:4007:5c00:1a60:24ff:fe97:84c9)
 by EX-SRV2.eckelmann.group (2a00:1f08:4007:e035:172:18:35:5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Mon, 8 Apr 2019 16:28:01 +0200
Date:   Mon, 8 Apr 2019 16:27:55 +0200
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Gavin Schenk <g.schenk@eckelmann.de>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <u.kleine-koenig@pengutronix.de>, <t.scherer@eckelmann.de>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS / Documentation: Thorsten Scherer is the
 successor of Gavin Schenk
Message-ID: <20190408142755.GA4719@ws067.eckelmann.group>
References: <20190408123208.10965-1-g.schenk@eckelmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190408123208.10965-1-g.schenk@eckelmann.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2a00:1f08:4007:5c00:1a60:24ff:fe97:84c9]
X-ClientProxiedBy: EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4)
 To EX-SRV2.eckelmann.group (2a00:1f08:4007:e035:172:18:35:5)
X-LASED-Pver: 0000002
X-Sophos-Email: [eu-central-1] Antispam-Engine: 3.1.5,
 AntispamData: 2019.4.8.141516
X-LASED-SpamProbabilty: 0.083173
X-LASED-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODYTEXTP_SIZE_400_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
 BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_300_399 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 FROM_SAME_AS_TO_DOMAIN 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
 MULTIPLE_RCPTS 0.100000, NO_URI_HTTPS 0.000000, REFERENCES 0.000000,
 WEBMAIL_SOURCE 0.000000, __ANY_URI 0.000000, __BOUNCE_CHALLENGE_SUBJ 0.000000,
 __BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __CD 0.000000, __CT 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FORWARDED_MSG 0.000000, __FROM_DOMAIN_IN_ANY_TO1 0.000000,
 __FROM_DOMAIN_IN_RCPT 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_XOIP 0.000000, __IN_REP_TO 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
 __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
 __URI_NO_WWW 0.000000, __USER_AGENT 0.000000
X-LASED-Authed: 1
X-LASED-Spam: NonSpam
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Mon, Apr 08, 2019 at 02:32:08PM +0200, Gavin Schenk wrote:
> Due to new challenges in my life I can no longer take care of SIOX.
> Thorsten takes over my SIOX tasks.
> 
> Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

I will take over Gavin's SIOX tasks.

Best regards
Thorsten
