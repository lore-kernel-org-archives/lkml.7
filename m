Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CBDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A84206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfDEQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:26:31 -0400
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:60268 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730565AbfDEQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:26:31 -0400
Received: from hsi-kbw-46-223-87-231.hsi.kabel-badenwuerttemberg.de ([46.223.87.231] helo=vega.skynet.aixah.de); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hCRfg-00035i-76; Fri, 05 Apr 2019 18:26:28 +0200
Received: by vega.skynet.aixah.de (Postfix, from userid 1005)
        id CF1ACE5352; Fri,  5 Apr 2019 18:26:27 +0200 (CEST)
Date:   Fri, 5 Apr 2019 18:26:27 +0200
From:   'Luis Ressel' <aranea@aixah.de>
To:     David Laight <David.Laight@aculab.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405162627.h3fadip7psc77zdf@vega.skynet.aixah.de>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1554481591;c5adfaf9;
X-HE-SMSGID: 1hCRfg-00035i-76
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:16:14PM +0000, David Laight wrote:

> In which case you should be looking at a way of removing -Wundef
> not removing -Werror.

No, my whole point is that this blacklisting approach doesn't work
outside a controlled dev environment, because different
compilers/compiler versions produce wildy different warnings.

I'm aware of several Linux distros which remove -Werror from build
systems whereever it is encountered. It's a well-known fact among
distributors that enabling -Werror for production builds is a bad idea.

Cheers,
Luis
