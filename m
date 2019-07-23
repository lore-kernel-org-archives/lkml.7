Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C0C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0386021E70
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HnrXmKkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfGWDnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:43:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfGWDnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OGJfh20y0GdgkUoUGpi3rt6LPSkAD4fS3ZbcXOkmYyY=; b=HnrXmKkS7xdCPOT0IXqRtBnzMB
        VREtgWfep0nb3eqkK/caYmiFE6EVnqUzmydT+PeAgpmrSV63iRUZBd5TD2a3AUzb1BjT5mg0fQOIX
        pou/H77gUxQ5H2Bv37heF3Fp8/n94T5/pHVMlCoCy7642Jblo25v8hpxf6/17Uah0vvgYh984eJOl
        papaSsdBN0NPY1HBSapg0+/z4i1DJtgntfhfg7XohjoI3nr3ZXJQDwzyW3tq6QHMe+6tbQEsrEitL
        j9X9GSO/okqle68ihEnrVvyW+/efiM5QicYafCgJWqUkjFXrj8FTwsbYEBtGtpI6lQ0NtpLuDguxV
        laf65VMQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hplhu-0002KH-JJ; Tue, 23 Jul 2019 03:43:19 +0000
Subject: Re: [PATCH] ktest: Fix some typos in config-bisect.pl
To:     Masanari Iida <standby24x7@gmail.com>, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
References: <20190723032445.14220-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a85708fc-784a-c877-d947-60aed778d72a@infradead.org>
Date:   Mon, 22 Jul 2019 20:43:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723032445.14220-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 8:24 PM, Masanari Iida wrote:
> This patch fixes some spelling typos in config-bisect.pl
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/testing/ktest/config-bisect.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/ktest/config-bisect.pl b/tools/testing/ktest/config-bisect.pl
> index 72525426654b..6fd864935319 100755
> --- a/tools/testing/ktest/config-bisect.pl
> +++ b/tools/testing/ktest/config-bisect.pl
> @@ -663,7 +663,7 @@ while ($#ARGV >= 0) {
>      }
>  
>      else {
> -	die "Unknow option $opt\n";
> +	die "Unknown option $opt\n";
>      }
>  }
>  
> @@ -732,7 +732,7 @@ if ($start) {
>  	}
>      }
>      run_command "cp $good_start $good" or die "failed to copy to $good\n";
> -    run_command "cp $bad_start $bad" or die "faield to copy to $bad\n";
> +    run_command "cp $bad_start $bad" or die "failed to copy to $bad\n";
>  } else {
>      if ( ! -f $good ) {
>  	die "Can not find file $good\n";
> 


-- 
~Randy
