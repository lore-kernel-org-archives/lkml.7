Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C747FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64712070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH2Qie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:38:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38382 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfH2Qid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:38:33 -0400
Received: from [10.91.6.157] (unknown [167.220.2.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id A826120B7186;
        Thu, 29 Aug 2019 09:38:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A826120B7186
Subject: Re: [PATCH] sefltest/ima: support appended signatures (modsig)
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Dave Young <dyoung@redhat.com>, shuah <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1566995946-6582-1-git-send-email-zohar@linux.ibm.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <631e1ef0-d975-cba9-9c55-cb15de49a562@linux.microsoft.com>
Date:   Thu, 29 Aug 2019 09:38:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566995946-6582-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 5:39 AM, Mimi Zohar wrote:
> Detect and allow appended signatures.

Ran the tests successfully on x86_64 QEMU

Reviewed-by: Jordan Hand <jorhand@linux.microsoft.com>
Tested-by: Jordan Hand <jorhand@linux.microsoft.com>
