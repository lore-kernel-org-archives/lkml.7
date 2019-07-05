Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EEDC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3CC2082F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfGEKLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:11:15 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:34090 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbfGEKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:11:15 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id B459918002E23
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2019 10:11:13 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EF1D81801BB73;
        Fri,  5 Jul 2019 10:11:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seed23_44a9efdbb190e
X-Filterd-Recvd-Size: 2467
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jul 2019 10:11:11 +0000 (UTC)
Message-ID: <9fecfbe081987df1415c9d12317fcfb782a0107e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: DT bindings vendor prefixes file yas been
 translated into yaml
From:   Joe Perches <joe@perches.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Date:   Fri, 05 Jul 2019 03:11:10 -0700
In-Reply-To: <20190705100345.29269-1-miquel.raynal@bootlin.com>
References: <20190705100345.29269-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-05 at 12:03 +0200, Miquel Raynal wrote:
> The extension is now .yaml instead of .txt.
> 
> Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bb28b178d929..9a3163020d67 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3027,7 +3027,7 @@ sub process {
>  			my @compats = $rawline =~ /\"([a-zA-Z0-9\-\,\.\+_]+)\"/g;
>  
>  			my $dt_path = $root . "/Documentation/devicetree/bindings/";
> -			my $vp_file = $dt_path . "vendor-prefixes.txt";
> +			my $vp_file = $dt_path . "vendor-prefixes.yaml";
>  
>  			foreach my $compat (@compats) {
>  				my $compat2 = $compat;

Already fixed in -next by:

commit 852d095d16a6298834839f441593f59d58a31978
Author: Rob Herring <robh@kernel.org>
Date:   Wed May 22 09:55:34 2019 -0500

    checkpatch.pl: Update DT vendor prefix check
    
    In commit 8122de54602e ("dt-bindings: Convert vendor prefixes to
    json-schema"), vendor-prefixes.txt has been converted to a DT schema.
    Update the checkpatch.pl DT check to extract vendor prefixes from the new
    vendor-prefixes.yaml file.
    
    Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
    Cc: Joe Perches <joe@perches.com>
    Signed-off-by: Rob Herring <robh@kernel.org>


