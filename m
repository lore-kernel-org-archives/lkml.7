Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E043FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD36D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfCNUnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:43:53 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:51800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726444AbfCNUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:43:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9BBC8180A8853;
        Thu, 14 Mar 2019 20:43:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: truck13_2192631deb04a
X-Filterd-Recvd-Size: 1801
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Mar 2019 20:43:50 +0000 (UTC)
Message-ID: <b772463a1c6e5ebb1677bebac30737c60f27a3e5.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add %pt as a valid vsprintf extension
From:   Joe Perches <joe@perches.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 14 Mar 2019 13:43:49 -0700
In-Reply-To: <20190314203719.29130-1-alexandre.belloni@bootlin.com>
References: <20190314203719.29130-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-14 at 21:37 +0100, Alexandre Belloni wrote:
> Commit 4d42c44727a0 ("lib/vsprintf: Print time and date in human readable
> format via %pt") introduced a new extension, %pt. Add it in the list of
> valid extensions.

Thanks.

Andrew, can you please pick this up?

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b737ca9d7204..35851755fbda 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5949,7 +5949,7 @@ sub process {
>  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
>  					$specifier = $1;
>  					$extension = $2;
> -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOx]/) {
> +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
>  						$bad_specifier = $specifier;
>  						last;
>  					}

