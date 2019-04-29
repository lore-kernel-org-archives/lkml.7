Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F7CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CBE20673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfD2ORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:17:55 -0400
Received: from foss.arm.com ([217.140.101.70]:58258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfD2ORy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:17:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94562A78;
        Mon, 29 Apr 2019 07:17:53 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8883F5C1;
        Mon, 29 Apr 2019 07:17:52 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:17:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] regulator: vexpress: Switch to SPDX identifier
Message-ID: <20190429141749.GB13159@e107155-lin>
References: <20190429113542.476-1-axel.lin@ingics.com>
 <20190429113542.476-2-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429113542.476-2-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:35:42PM +0800, Axel Lin wrote:

I prefer to have a line of description, worst case repeat the subject,
but don't leave empty.

With that:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
