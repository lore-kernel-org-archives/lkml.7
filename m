Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD47C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C42B20665
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfFFOM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:12:58 -0400
Received: from ns.iliad.fr ([212.27.33.1]:53966 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfFFOM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:12:57 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1FC4E20F58;
        Thu,  6 Jun 2019 16:12:56 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 0DF1220ECD;
        Thu,  6 Jun 2019 16:12:56 +0200 (CEST)
Subject: Re: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20190604222939.195471-1-swboyd@chromium.org>
 <20190604223700.GE4814@minitux> <5cf6f4bb.1c69fb81.c39da.5496@mx.google.com>
 <CAFp+6iHZeawnz7Vfk3=Oox-GN_y6c-E9wMwc-qdp1bTOXgqjFQ@mail.gmail.com>
 <5cf82c6f.1c69fb81.9e342.dbda@mx.google.com>
 <CAFp+6iE8FUXxexKbYy=ak+se-pj1XXUZxTu5o=hJvg66V6+Rzw@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <66a4a987-ac89-609f-1496-895765f9b1f2@free.fr>
Date:   Thu, 6 Jun 2019 16:12:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iE8FUXxexKbYy=ak+se-pj1XXUZxTu5o=hJvg66V6+Rzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jun  6 16:12:56 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2019 13:17, Vivek Gautam wrote:

> <&apps_smmu 0x6c0 0x3>   // for both 0x6c0 (TZ) and 0x6c3 (HLOS)

Another possibility is to list both:

	<&apps_smmu 0x6c0 0x0>
	<&apps_smmu 0x6c3 0x0>

which leaves 0x6c1 and 0x6c2 out of the picture, and makes 0x6c3
appear explicitly (for anyone checking the documentation).

Regards.
