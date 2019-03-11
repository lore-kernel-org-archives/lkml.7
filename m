Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76298C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479AD2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCKLtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:49:53 -0400
Received: from verein.lst.de ([213.95.11.211]:40794 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfCKLtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:49:53 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 5763C68C7B; Mon, 11 Mar 2019 12:49:46 +0100 (CET)
Date:   Mon, 11 Mar 2019 12:49:46 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v8 0/5] arm64: ftrace with regs
Message-ID: <20190311114945.GA5625@lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de> <0f8d2e77-7e51-fba8-b179-102318d9ff84@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f8d2e77-7e51-fba8-b179-102318d9ff84@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:11:04AM +0000, Julien Thierry wrote:
> Hi Torsten,
> 
> On 08/02/2019 15:08, Torsten Duwe wrote:
> > Patch series v8, as discussed.
> > The whole series applies cleanly on 5.0-rc5

So what's the status now? Besides debatable minor style
issues there were no more objections to v8. Would this
go through the ARM repo or via the ftrace repo?

	Torsten

