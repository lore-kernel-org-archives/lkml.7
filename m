Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C65C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBDC20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfGJWah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:30:37 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:38004 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727222AbfGJWag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:30:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F376B182CF67C;
        Wed, 10 Jul 2019 22:30:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: group31_794d726ad7435
X-Filterd-Recvd-Size: 2043
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 22:30:33 +0000 (UTC)
Message-ID: <bc0f21dd8753190c6fbba0d3f7469a2d8c87b341.camel@perches.com>
Subject: Re: [PATCH] Staging: rtl8723bs: hal: rtl8723bs_recv.c: Fix code
 style
From:   Joe Perches <joe@perches.com>
To:     Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Jul 2019 15:30:32 -0700
In-Reply-To: <20190708095652.18174-1-fatihaltinpinar@gmail.com>
References: <20190708095652.18174-1-fatihaltinpinar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-08 at 12:56 +0300, Fatih ALTINPINAR wrote:
> Fixed a coding stlye issue. Removed braces from a single statement if
> block.
> 
> Signed-off-by: Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> index e23b39ab16c5..71a4bcbeada9 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> @@ -449,9 +449,8 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
>  				skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
>  			}
>  
> -			if (!precvbuf->pskb) {
> +			if (!precvbuf->pskb)
>  				DBG_871X("%s: alloc_skb fail!\n", __func__);
> -			}

You could delete the block instead.
alloc_skb failures already do a dump_stack()


