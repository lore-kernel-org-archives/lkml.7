Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61635C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4464A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfJJXC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:02:59 -0400
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:33093 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbfJJXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:02:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id EE2ED182CED28;
        Thu, 10 Oct 2019 23:02:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: frame79_53e2ee6598517
X-Filterd-Recvd-Size: 1572
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Oct 2019 23:02:56 +0000 (UTC)
Message-ID: <fbaeb107184c64e9cfa52a416809bc8866e40adc.camel@perches.com>
Subject: Re: [PATCH] MIPS: OCTEON: Replace SIZEOF_FIELD() macro
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Oct 2019 16:02:55 -0700
In-Reply-To: <201910101545.586BCFC@keescook>
References: <201910101545.586BCFC@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 15:46 -0700, Kees Cook wrote:
> In preparation for switching to a standard sizeof_member() macro to find the
> size of a member of a struct, remove the custom SIZEOF_FIELD() macro and use
> the more common FIELD_SIZEOF() instead. Later patches will globally replace
> FIELD_SIZEOF() and sizeof_field() with the more accurate sizeof_member().

Is the intent to have a single treewide flag day conversion of
FIELD_SIZEOF -> sizeof_member or submit individual patches to
subsystem maintainers?

I don't recall Linus buying in to either mechanism.

