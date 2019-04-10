Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67BAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80342082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfDJQZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:25:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57540 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731986AbfDJQZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:25:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A226E374;
        Wed, 10 Apr 2019 09:25:40 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925FC3F59C;
        Wed, 10 Apr 2019 09:25:39 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:25:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: check return value of idr_find
Message-ID: <20190410162537.GF3952@e107155-lin>
References: <20190309040239.32431-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309040239.32431-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:02:39PM -0600, Kangjie Lu wrote:
> idr_find may return NULL, so check its return value and return an
> error code.
> 

I can't imagine a scenario leading to this. Steven has already explained
why, so I won't repeat the same here. Did you hit this issue ?

If so I would like to know details, so that we can bail out much earlier
where the failure occurs than proceed until this point.

--
Regards,
Sudeep
