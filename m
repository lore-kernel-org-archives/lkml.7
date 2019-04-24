Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB19D2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfDXKAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:00:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDXKAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:00:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5658C079C3D;
        Wed, 24 Apr 2019 10:00:09 +0000 (UTC)
Received: from localhost (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 507901001DE7;
        Wed, 24 Apr 2019 10:00:06 +0000 (UTC)
Date:   Wed, 24 Apr 2019 18:00:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, hpa@zytor.com
Subject: Re: [PATCH v5 0/2] x86/boot: Use efi_setup_data for searching RSDP
 on kexec-ed kernel
Message-ID: <20190424100004.GJ3584@localhost.localdomain>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424093852.GB30142@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424093852.GB30142@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 24 Apr 2019 10:00:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/19 at 11:38am, Borislav Petkov wrote:
> On Wed, Apr 24, 2019 at 05:29:42PM +0800, Baoquan He wrote:
> > In this series, patch 2/2 has dependency on patch 1/1, otherwise
> > it may cause system to reset to firmware on some machines.
> > 
> > The patch 2/2 is the version Boris organized:
> > http://lkml.kernel.org/r/20190416095209.GG27892@zn.tnic
> > 
> > Patch 1/1 is based on Kairui's v1 patch, and add ACPI tables mapping:
> > http://lkml.kernel.org/r/20190422092804.15534-1-kasong@redhat.com
> > 
> > Dave Young confirmed this patchset passed test on his t420 laptop, where
> > the system resetting issue caused by patch 2/2 was found.
> 
> I guess but this does not give me the warm and fuzzy feeling one week
> before the merge window.
> 
> So:
> 
> https://git.kernel.org/tip/36f0c423552dacaca152324b8e9bda42a6d88865
> 
> and we all can relax ourselves and take the next release cycle to test
> the hell out of this before reenabling it again.

OK, then let's hold till the next window opening.
