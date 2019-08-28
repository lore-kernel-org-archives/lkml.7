Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB958C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F74B2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfH1QPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:15:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbfH1QPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4527AFE8;
        Wed, 28 Aug 2019 16:15:42 +0000 (UTC)
Date:   Wed, 28 Aug 2019 18:15:40 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Neuling <mikey@neuling.org>,
        David Hildenbrand <david@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/4] fs: always build llseek.
Message-ID: <20190828181540.21fa33a4@naga>
In-Reply-To: <20190828151552.GA16855@infradead.org>
References: <cover.1566936688.git.msuchanek@suse.de>
        <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
        <20190828151552.GA16855@infradead.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 08:15:52 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Aug 27, 2019 at 10:21:06PM +0200, Michal Suchanek wrote:
> > 64bit !COMPAT does not build because the llseek syscall is in the tables.  
> 
> Well, this will bloat thinkgs like 64-bit RISC-V for no good reason.
> Please introduce a WANT_LSEEK like symbol that ppc64 can select instead.

It also builds when llseek is marked as 32bit only in syscall.tbl

It seems it was handled specially in some way before syscall.tbl was
added, though (removed in ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5)

Thanks

Michal
