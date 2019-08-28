Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195C0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E926E22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH1OiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:38:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:52820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfH1OiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:38:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DBC8ABED;
        Wed, 28 Aug 2019 14:37:59 +0000 (UTC)
Date:   Wed, 28 Aug 2019 16:37:57 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Disable compat cruft on ppc64le v2
Message-ID: <20190828163757.123e0eba@naga>
In-Reply-To: <dbc5abde-ea15-be43-1fdb-d16052c19e03@c-s.fr>
References: <cover.1566987936.git.msuchanek@suse.de>
        <dbc5abde-ea15-be43-1fdb-d16052c19e03@c-s.fr>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 13:08:48 +0000
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> On 08/28/2019 10:30 AM, Michal Suchanek wrote:
> > With endian switch disabled by default the ppc64le compat supports
> > ppc32le only which is something next to nobody has binaries for.
> > 
> > Less code means less bugs so drop the compat stuff.
> > 
> > I am not particularly sure about the best way to resolve the llseek
> > situation. I don't see anything in the syscal tables making it
> > 32bit-only so I suppose it should be available on 64bit as well.
> > 
> > This is tested on ppc64le top of  
> 
> Really ?

Really. It boots with the unused variable. It might depend on some
config options or gcc features if unused variables are fatal.

Thanks

Michal
