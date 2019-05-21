Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40322C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7BF21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfEUCRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:17:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfEUCRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:17:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFE39341;
        Mon, 20 May 2019 19:17:15 -0700 (PDT)
Received: from [10.162.42.136] (p8cg001049571a15.blr.arm.com [10.162.42.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36A23F718;
        Mon, 20 May 2019 19:17:13 -0700 (PDT)
Subject: Re: [PATCH v2] mm, memory-failure: clarify error message
To:     Jane Chu <jane.chu@oracle.com>, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     linux-nvdimm@lists.01.org
References: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f1e4d5e9-e0a7-1a88-f5a5-de9a350e37ef@arm.com>
Date:   Tue, 21 May 2019 07:47:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2019 07:22 AM, Jane Chu wrote:
> Some user who install SIGBUS handler that does longjmp out
> therefore keeping the process alive is confused by the error
> message
>   "[188988.765862] Memory failure: 0x1840200: Killing
>    cellsrv:33395 due to hardware memory corruption"
> Slightly modify the error message to improve clarity.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
