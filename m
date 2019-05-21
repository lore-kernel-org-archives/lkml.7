Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3031DC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDFE21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfEUHY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:24:58 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:56221 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbfEUHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:24:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C7C8C837F24C;
        Tue, 21 May 2019 07:24:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail78_481f05a1cd332
X-Filterd-Recvd-Size: 1175
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 May 2019 07:24:55 +0000 (UTC)
Message-ID: <a18a87a4ef54168148f0d278601782f5f6442830.camel@perches.com>
Subject: Re: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 00:24:54 -0700
In-Reply-To: <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
References: <20190521061659.6073-1-yamada.masahiro@socionext.com>
         <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 08:53 +0200, Christophe Leroy wrote:
> powerpc accepts lines up to 90 chars, see arch/powerpc/tools/checkpatch.pl

arch/powerpc/tools/checkpatch.sh


