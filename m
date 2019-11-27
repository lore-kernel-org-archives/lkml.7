Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDBBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEB92075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfK0Vkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:40:36 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:35187 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729348AbfK0Umm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:42:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1F9C6837F24D;
        Wed, 27 Nov 2019 20:42:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: screw31_34379b223a41f
X-Filterd-Recvd-Size: 1759
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Nov 2019 20:42:38 +0000 (UTC)
Message-ID: <80168e5bebedeb64e999ed11d8479846270bd3d7.camel@perches.com>
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Date:   Wed, 27 Nov 2019 12:42:12 -0800
In-Reply-To: <20191127175051.1351346-1-jim.cromie@gmail.com>
References: <20191127175051.1351346-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-27 at 10:50 -0700, Jim Cromie wrote:
> dyndbg populates its callsite info into __verbose section, change that
> to a more specific and descriptive name, __dyndbg.
[]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -1040,7 +1040,7 @@ static int __init dynamic_debug_init(void)
>  	ddebug_init_success = 1;
>  	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",

This format should also change verbose to dyndbg
Maybe the ddebug word too

>  		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
> -		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
> +		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
>  
>  	/* apply ddebug_query boot param, dont unload tables on err */
>  	if (ddebug_setup_string[0] != '\0') {

