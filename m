Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7DC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297BE206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:47:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:48282 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfLXOrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:47:07 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBOEkNuV031561;
        Tue, 24 Dec 2019 08:46:23 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id xBOEkMoQ031560;
        Tue, 24 Dec 2019 08:46:22 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 24 Dec 2019 08:46:21 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     christophe leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v2 04/10] lib: vdso: get pointer to vdso data from the arch
Message-ID: <20191224144621.GG4505@gate.crashing.org>
References: <de5273aa-69dc-8e37-c917-44708257d2ba@c-s.fr> <D2614EC4-5B80-4846-994D-22730ACD44A1@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D2614EC4-5B80-4846-994D-22730ACD44A1@amacapital.net>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 08:15:11PM +0800, Andy Lutomirski wrote:
> Does power have PC-relative data access?  If so, I wonder if the code can be arranged so that even the array accesses don’t require computing an absolute address at any point.

Not before ISA 3.0 (that is Power9).

The bcl/mflr dance isn't *that* expensive, if you use it sparingly.


Segher
