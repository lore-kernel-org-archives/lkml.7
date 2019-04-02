Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E706C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C16820856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfDBKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:50:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13991
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbfDBKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:50:47 -0400
X-IronPort-AV: E=Sophos;i="5.60,300,1549926000"; 
   d="scan'208";a="301509852"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 12:50:27 +0200
Date:   Tue, 2 Apr 2019 12:50:23 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wen.yang99@zte.com.cn>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 7/7] cpufreq: ppc_cbe: fix possible object reference
 leak
In-Reply-To: <efe8fb3a-eb4a-a50a-c53a-0879a912fbd8@web.de>
Message-ID: <alpine.DEB.2.20.1904021249500.3297@hadrien>
References: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn> <efe8fb3a-eb4a-a50a-c53a-0879a912fbd8@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2019212169-1554202224=:3297"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-2019212169-1554202224=:3297
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 2 Apr 2019, Markus Elfring wrote:

> > The call to of_get_cpu_node returns a node pointer with refcount
> > incremented thus it must be explicitly decremented after the last
> > usage.
>
> I would prefer a wording like the following.
>
> A reference counter was incremented for a CPU node by a call of
> the function “of_get_cpu_node”.
> Thus decrement it after the last usage.

The original log message seems perfectly clear.

>
>
> > Detected by coccinelle with the following warnings:
>
> I wonder about the shown duplicate notification.
> Can a single message be sufficient for the code search result
> in this source file?

Since you have removed the context, I have no idea what you are talking
about.

julia
--8323329-2019212169-1554202224=:3297--
