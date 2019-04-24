Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F30208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfDXQRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfDXQRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:17:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0F2D89AE4;
        Wed, 24 Apr 2019 16:17:34 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BB96608C1;
        Wed, 24 Apr 2019 16:17:33 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:17:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <Raphael.Gault@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC 1/6] objtool: Refactor code to make it more suitable for
 multiple architecture support
Message-ID: <20190424161732.lnttohdvhujtey64@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-2-raphael.gault@arm.com>
 <20190423201306.wyb57hz7xrvqbn75@treble>
 <13212ab1-20fe-88c6-f121-acd8ea623757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13212ab1-20fe-88c6-f121-acd8ea623757@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 24 Apr 2019 16:17:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:11:57PM +0000, Raphael Gault wrote:
> On 4/23/19 9:13 PM, Josh Poimboeuf wrote:
> > arch_dest_rela_addend_offset() might be a more descriptive name.  Also
> > it might be simpler to just make it an arch-specific macro which is 0 on
> > arm64 and 4 on x86.
> >
> > "compute" is implied, it can probably be removed from the names to make
> > them a little more concise.
> >
> 
> I am more in favor of the functions, I have to admit I don't know which
> is really better but in any event I will rename them.

If you prefer functions, that's fine with me.  I don't have a strong
preference.

-- 
Josh
