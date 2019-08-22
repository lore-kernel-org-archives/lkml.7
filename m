Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5FDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C36721743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbfHVNem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:34:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:59826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730621AbfHVNem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:34:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA486AAB2;
        Thu, 22 Aug 2019 13:34:40 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:34:40 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] KVM: SVM: Add KVM_SEND_UPDATE_DATA command
Message-ID: <20190822133440.GD11845@zn.tnic>
References: <20190710201244.25195-1-brijesh.singh@amd.com>
 <20190710201244.25195-3-brijesh.singh@amd.com>
 <20190822120254.GC11845@zn.tnic>
 <9c8fd645-8908-7ece-b60d-20de6f246df8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c8fd645-8908-7ece-b60d-20de6f246df8@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:27:25PM +0000, Singh, Brijesh wrote:
> FW accepts the system physical address but the userspace does not know
> the system physical instead it will give host virtual address and we
> will find its corresponding system physical address and make a FW
> call. This is a userspace interface and not the FW.

That fact could be in a sentence or two as a comment above the struct
definition.

> Okay, I will take a look and will probably reuse your functions. thank you.

Sure, and pls see if you can simplify the other command-sending
functions in a similar manner.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
