Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC65C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5EE25551
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFBUHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 16:07:34 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:35810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbfFBUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 16:07:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3F17E688F;
        Sun,  2 Jun 2019 20:07:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: frog64_79a000550354
X-Filterd-Recvd-Size: 1430
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 20:07:32 +0000 (UTC)
Message-ID: <9ca0c459d047c72fc459313ad570ecc59cf5d300.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove redundant definition of
 ETH_ALEN
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Jun 2019 13:07:30 -0700
In-Reply-To: <20190602163528.28495-1-straube.linux@gmail.com>
References: <20190602163528.28495-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 18:35 +0200, Michael Straube wrote:
> ETH_ALEN is defined in linux/if_ether.h which is included by
> osdep_service.h, so remove the redundant definition from ieee80211.h.
[]
> diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
[]
> @@ -14,7 +14,6 @@
>  
>  #define MGMT_QUEUE_NUM 5
>  
> -#define ETH_ALEN	6
>  #define ETH_TYPE_LEN		2
>  #define PAYLOAD_TYPE_LEN	1

While you're at it:

neither ETH_TYPE_LEN nor PAYLOAD_TYPE_LEN appear to be used.


