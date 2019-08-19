Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD92FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899AE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHSH7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:59:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfHSH7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:59:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E76337;
        Mon, 19 Aug 2019 00:59:35 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7250E3F718;
        Mon, 19 Aug 2019 00:59:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] arm64: perf: Enable pmu counter direct access for
 perf event on armv8
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org, mark.rutland@arm.com, raph.gault+kdev@gmail.com
References: <20190816125934.18509-5-raphael.gault@arm.com>
 <201908182002.KAH4UW2w%lkp@intel.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <a41e1a4b-b082-725a-b24e-9c92f66d174a@arm.com>
Date:   Mon, 19 Aug 2019 08:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201908182002.KAH4UW2w%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/19 1:37 PM, kbuild test robot wrote:
> Hi Raphael,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc4 next-20190816]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

This patchset was based on linux-next/master and note linus

Thanks,

-- 
Raphael Gault
