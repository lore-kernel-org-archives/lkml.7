Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFDFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1304021874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="J2uonOD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfCVKcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:32:20 -0400
Received: from smtp121.ord1c.emailsrvr.com ([108.166.43.121]:41437 "EHLO
        smtp121.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbfCVKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:32:17 -0400
Received: from smtp16.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp16.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 70921C015E;
        Fri, 22 Mar 2019 06:32:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1553250736;
        bh=+4yxma7HhyrADNFgBq6NIOR6WVFoLmtVRk+ISIMRzNA=;
        h=Subject:To:From:Date:From;
        b=J2uonOD0C9Rm3QUb5anLn9mXla4hxucEkCCT7W0hOIzvrSkI3lnV9fhss05iHeVMJ
         6bxnm3StMEfMBYDwMr/kW0A03YJ3BQFmt33YwsfL6jb5D33L4QxlS1YMiO48hKQQag
         n0RVCp4vIvDWONe9HRILg3aV2yce/1PkTOJy7cbo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 767CAC00B9;
        Fri, 22 Mar 2019 06:32:15 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 22 Mar 2019 06:32:16 -0400
Subject: Re: [PATCH] Staging: comedi: ni_mio_common.c: Added blank line after
 declarations
To:     Arash Fotouhi <arash@arashfotouhi.com>
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        olsonse@umich.edu, giulio.benetti@micronovasrl.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1553195892-40323-1-git-send-email-arash@arashfotouhi.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <0c2aeba6-5791-3787-2a08-e4bdd4ea0cd0@mev.co.uk>
Date:   Fri, 22 Mar 2019 10:32:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553195892-40323-1-git-send-email-arash@arashfotouhi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2019 19:18, Arash Fotouhi wrote:
> Added blank line after declarations.
> 
> Signed-off-by: Arash Fotouhi <arash@arashfotouhi.com>
> ---
>   drivers/staging/comedi/drivers/ni_mio_common.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
> index 5edf59a..c6aff8f 100644
> --- a/drivers/staging/comedi/drivers/ni_mio_common.c
> +++ b/drivers/staging/comedi/drivers/ni_mio_common.c
> @@ -2110,6 +2110,7 @@ static int ni_ai_cmdtest(struct comedi_device *dev, struct comedi_subdevice *s,
>   
>   	if (cmd->scan_begin_src == TRIG_TIMER) {
>   		unsigned int tmp = cmd->scan_begin_arg;
> +
>   		cmd->scan_begin_arg =
>   		    ni_timer_to_ns(dev, ni_ns_to_timer(dev,
>   						       cmd->scan_begin_arg,
> @@ -2120,6 +2121,7 @@ static int ni_ai_cmdtest(struct comedi_device *dev, struct comedi_subdevice *s,
>   	if (cmd->convert_src == TRIG_TIMER) {
>   		if (!devpriv->is_611x && !devpriv->is_6143) {
>   			unsigned int tmp = cmd->convert_arg;
> +
>   			cmd->convert_arg =
>   			    ni_timer_to_ns(dev, ni_ns_to_timer(dev,
>   							       cmd->convert_arg,
> 

Looks good, thanks.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
