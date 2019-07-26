Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BD4218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfGZQto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:49:44 -0400
Received: from foss.arm.com ([217.140.110.172]:47346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbfGZQto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:49:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0946337;
        Fri, 26 Jul 2019 09:49:43 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ABA33F71F;
        Fri, 26 Jul 2019 09:49:42 -0700 (PDT)
Subject: Re: [PATCH] arm64/kexec: Use consistent convention of initializing
 'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, takahiro.akashi@linaro.org,
        will.deacon@arm.com
References: <1562846252-7441-1-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <839b08dc-36ae-fb94-0c0a-00e6ee8a5790@arm.com>
Date:   Fri, 26 Jul 2019 17:49:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562846252-7441-1-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 11/07/2019 12:57, Bhupesh Sharma wrote:
> With commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()"),
> we introduced the KEXEC_BUF_MEM_UNKNOWN macro. If kexec_buf.mem is set
> to this value, kexec_locate_mem_hole() will try to allocate free memory.
> 
> While other arch(s) like s390 and x86_64 already use this macro to
> initialize kexec_buf.mem with, arm64 uses an equivalent value of 0.
> Replace it with KEXEC_BUF_MEM_UNKNOWN, to keep the convention of
> initializing 'kxec_buf.mem' consistent across various archs.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
