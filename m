Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E7BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68A920880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfHFHDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:03:12 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35635 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731557AbfHFHDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:03:12 -0400
Received: from [192.168.0.6] (ip5f5bd17d.dynamic.kabel-deutschland.de [95.91.209.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B8E2201A3C2F;
        Tue,  6 Aug 2019 09:03:09 +0200 (CEST)
Subject: Unrelated question and threading (was: Bisected: Kernel 4.14 + has 3
 times higher write IO latency than Kernel 4.4 with raid1)
To:     Rick Nilsson <riccardofarabia@gmail.com>,
        NeilBrown <neilb@suse.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-kernel@vger.kernel.org
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
 <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de>
 <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
 <CAMGffEkcXcQC+kjwdH0iVSrFDk-o+dp+b3Q1qz4z=R=6D+QqLQ@mail.gmail.com>
 <87h86vjhv0.fsf@notabene.neil.brown.name>
 <6a1dcbe6e3ddb03912f8904a368d40c09dd22bd1.camel@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a6803af2-eb2c-0563-f7d4-8b7ab356c201@molgen.mpg.de>
Date:   Tue, 6 Aug 2019 09:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6a1dcbe6e3ddb03912f8904a368d40c09dd22bd1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rick,


It looks like your message is unrelated to the thread at hand. 
Therefore, please start a new thread by *not* using the reply feature, 
but create a new message in your mail program (MUA).

Please read some mailing list etiquettes on the Web like [1].


Kind regards,

Paul


[1]: https://wiki.openstack.org/wiki/MailingListEtiquette
