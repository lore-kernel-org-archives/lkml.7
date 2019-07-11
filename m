Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47631C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2055120838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfGKQ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 12:26:20 -0400
Received: from ns.iliad.fr ([212.27.33.1]:33542 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbfGKQ0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:26:19 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3DD41208E6;
        Thu, 11 Jul 2019 18:26:18 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 1F77820666;
        Thu, 11 Jul 2019 18:26:18 +0200 (CEST)
Subject: Re: [Patch V4] Documentation: coresight: covert txt to rst
To:     Phong Tran <tranmanphong@gmail.com>, corbet@lwn.net,
        leo.yan@linaro.org, mathieu.poirier@linaro.org, mchehab@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        suzuki.poulose@arm.com
References: <20190705204512.15444-1-tranmanphong@gmail.com>
 <20190710150133.13992-1-tranmanphong@gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <808533ea-69d2-4df9-e6e2-442ec29dd8a9@free.fr>
Date:   Thu, 11 Jul 2019 18:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190710150133.13992-1-tranmanphong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jul 11 18:26:18 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2019 17:01, Phong Tran wrote:
> Subject: [Patch V4] Documentation: coresight: covert txt to rst

Typo in patch subject.

s/covert/convert
