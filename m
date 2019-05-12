Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95907C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 02:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6274F20881
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 02:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfELCeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 22:34:13 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:39783 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbfELCeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 22:34:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 272FBC1DC93;
        Sun, 12 May 2019 02:34:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream79_41757a7749e48
X-Filterd-Recvd-Size: 1278
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 May 2019 02:34:09 +0000 (UTC)
Message-ID: <1e6ec2fac918b4dcad2c8579970f2fea664c5474.camel@perches.com>
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@linaro.org>, davem@davemloft.net, arnd@arndb.de,
        bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org,
        subashab@codeaurora.org, stranche@codeaurora.org,
        yuehaibing@huawei.com
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org
Date:   Sat, 11 May 2019 19:34:08 -0700
In-Reply-To: <20190512012508.10608-3-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
         <20190512012508.10608-3-elder@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 20:24 -0500, Alex Elder wrote:
>  include/soc/qcom/rmnet.h

Should this file be added to the MAINTAINERS file
update in patch 16/18 ?

