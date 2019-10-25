Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F43CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7182070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410339AbfJYLXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:23:12 -0400
Received: from comms.puri.sm ([159.203.221.185]:48150 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfJYLXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:23:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2785FDFFDB;
        Fri, 25 Oct 2019 04:23:11 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n3Wpa7Rk3YNc; Fri, 25 Oct 2019 04:23:10 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        leo.yan@linaro.org, edubezval@gmail.com,
        vincent.guittot@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
Date:   Fri, 25 Oct 2019 13:22:55 +0200
Message-Id: <20191025112255.9253-1-martin.kepplinger@puri.sm>
In-Reply-To: <34b1ed94-1223-60ec-ac4f-0b32be67eab2@linaro.org>
References: <34b1ed94-1223-60ec-ac4f-0b32be67eab2@linaro.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Quick note: You're missing a kref_init() in this version of the cooling driver.

Also, as already mentioned, set_freezable() doesn't seem to work without
supporting suspend/resume.

And since cpuidle got somewhat completely reworked in 5.4, could you create
a new, rebased version of this? Let me know in case I missed an earlier update.

thanks,

                              martin


---
