Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479C5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C62082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfFMPYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:24:02 -0400
Received: from foss.arm.com ([217.140.110.172]:39072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731746AbfFMMWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:22:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42F202B;
        Thu, 13 Jun 2019 05:22:50 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65EAC3F694;
        Thu, 13 Jun 2019 05:22:48 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:22:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/2] mm: kmemleak: change error at _write when
 kmemleak is disabled
Message-ID: <20190613122243.GQ28951@C02TF0J2HF1T.local>
References: <20190612155231.19448-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612155231.19448-1-andrealmeid@collabora.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:52:30PM -0300, André Almeida wrote:
> According to POSIX, EBUSY means that the "device or resource is busy",
> and this can lead to people thinking that the file
> `/sys/kernel/debug/kmemleak/` is somehow locked or being used by other
> process. Change this error code to a more appropriate one.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
