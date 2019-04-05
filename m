Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5CC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11F021738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfDERMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbfDERMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:12:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5238030018E0;
        Fri,  5 Apr 2019 17:12:10 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A15655D9C4;
        Fri,  5 Apr 2019 17:12:09 +0000 (UTC)
Date:   Fri, 5 Apr 2019 12:12:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Luis Ressel' <aranea@aixah.de>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405171207.jmi7zehu37ksg5a4@treble>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
 <20190405162109.4hv6lqpd6manzjju@treble>
 <d3cb290b12974f1895ea235680f90ead@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3cb290b12974f1895ea235680f90ead@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 05 Apr 2019 17:12:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:35:50PM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > Sent: 05 April 2019 17:21
> ..
> > > FWIW I had to update libelf.so from version 0.153 to 0.165 in
> > > order for the amd64 orc unwinder code in objtool to not generate
> > > corrupt output files.
> > > That is an Ubuntu 13.04 system - nothing like 10 years old.
> > 
> > Ah.  It would be great if we had a patch to fail the build for old
> > versions of elfutils-libelf as well.
> 
> I think the check I added for that specific error got committed.
> Look at the defintion of cmd_objtool in scripts/Makefile.build.
> 
> Although I seem to have a local change to the definition of
> cmd_modversions_c.
> It might be that the version of a change I made that got committed
> is missing an extra $ when processing the saved output from 'objdump -h'.
> It used to just pipe into grep - so lost the error result from objdump.

Hm, I don't see that in cmd_objtool, or any commits from you in
scripts/Makefile.build.

-- 
Josh
