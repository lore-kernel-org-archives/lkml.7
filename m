Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8F0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF1222B5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfKSNSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:18:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:39940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKSNSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:18:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 210A3B03A;
        Tue, 19 Nov 2019 13:18:16 +0000 (UTC)
Subject: Re: [PATCH 2/2] x86/Xen/32: simplify xen_iret_crit_fixup's ring check
To:     Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
 <a5986837-01eb-7bf8-bf42-4d3084d6a1f5@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <fcfc2cc3-4f98-882d-ed14-d6e2e4d8731d@suse.com>
Date:   Tue, 19 Nov 2019 14:18:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a5986837-01eb-7bf8-bf42-4d3084d6a1f5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.19 15:32, Jan Beulich wrote:
> This can be had with two instead of six insns, by just checking the high
> CS.RPL bit.
> 
> Also adjust the comment - there would be no #GP in the mentioned cases,
> as there's no segment limit violation or alike. Instead there'd be #PF,
> but that one reports the target EIP of said branch, not the address of
> the branch insn itself.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
