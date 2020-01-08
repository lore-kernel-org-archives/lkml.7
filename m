Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B16C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6FE20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgAHS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:27:51 -0500
Received: from namei.org ([65.99.196.166]:56196 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbgAHS1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:27:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 008IRGfL027152;
        Wed, 8 Jan 2020 18:27:16 GMT
Date:   Thu, 9 Jan 2020 05:27:16 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     KP Singh <kpsingh@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF
 (KRSI)
In-Reply-To: <201912301112.A1A63A4@keescook>
Message-ID: <alpine.LRH.2.21.2001090525540.9683@namei.org>
References: <20191220154208.15895-1-kpsingh@chromium.org> <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com> <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com> <201912301112.A1A63A4@keescook>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019, Kees Cook wrote:

> 
> Given the discussion around tracing and stable ABI at the last kernel
> summit, Linus's mandate is mainly around "every day users" and not
> around these system-builder-sensitive cases where everyone has a strong
> expectation to rebuild their policy when the kernel changes. i.e. it's
> not "powertop", which was Linus's example of "and then everyone running
> Fedora breaks".
> 
> So, while I know we've tried in the past to follow the letter of the
> law, it seems Linus really expects this only to be followed when it will
> have "real world" impact on unsuspecting end users.
> 
> Obviously James Morris has the final say here, but as I understand it,
> it is fine to expose these here for the same reasons it's fine to expose
> the (ever changing) tracepoints and BPF hooks.

Agreed. This API should be seen in the same light as tracing / debugging, 
and it should not be exposed by users directly to general purpose 
applications.


-- 
James Morris
<jmorris@namei.org>

