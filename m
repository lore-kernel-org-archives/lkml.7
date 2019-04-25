Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56EEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B81206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfDYKqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:46:53 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:36449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfDYKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:46:53 -0400
Received: from [192.168.1.115] ([95.115.19.22]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mcp3E-1gkp2c3gf4-00ZzjB; Thu, 25 Apr 2019 12:46:20 +0200
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
 <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com>
 <6a9e6bd9-8e1a-9fe5-135d-c7a49697b5a4@metux.net>
 <4456cc68-5120-e820-90ed-cb5b5dfcd760@linux.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ee1620d5-9650-5bfa-c458-fa2d051522b1@metux.net>
Date:   Thu, 25 Apr 2019 12:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4456cc68-5120-e820-90ed-cb5b5dfcd760@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZnkALXkHHwZE1EE2jFTNP4RMHM6mt7IN4RNRxxzkIoEJQ8b01n7
 ZlZ+Q04+zSYDioS1BzpbePww5eI0r2ltoqRByeNAFgMDWGoHIaG8ceLYGBIhnWLyZmbLfvb
 nf7rLfpyyST+bpF+XOSLWAJwNQGCWcqO5p7+8GSkpWbvKPooTfmf5M/o9O7dkcEJFiQKeGH
 cTdTPdjQ8jGuZFi9KI9kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gnYz11fW57A=:yQd8eRO0sQM4pPBuihPDPl
 UYi73k456SbyHl5c4k+eVJ0pDShAUtscC2JtxeODqa3bwBYkb2ge6IOCWFW1hdANRYiI6kQK1
 L9vv53hy+E9RDxrkgURZEQNab9w5QWII8Qs6sObFYMUViFxIs1jcIswvuSMF1kve2qyJ+OmTF
 TFQvoHRVodE0gY1n/kQsM3Q/yGEpoTAbcl+AlNx52w6RFFRSQiAgCPXHb1FYIV6oXhFtHX9bs
 13b+wsJ/4KFh7mJZpvorsaEhFfy08CnsytO6jtxD0fWzau7OC28aq8EylUvXQX1so9SRywXC9
 +mTpxuOCVHq8ikyau0ZcTG9k5Yi3va5VMFIXLwAks6vjZwzrTSR/jtZpDcuTYSYIJabmXXKmi
 2cBGKF3F780UsCWIl7ok5RDn19gqXP1UXaAWRqVZrX4Sk60vpmZABsIhU57mpIAjas4SL4rF8
 dcUoII1dmFn2aESU7rY5TDiIkz0026NTn2B757F6DK/cSzT3ROCtgKbuILJmJE1Edz8W0d6FB
 m3fc7AbH9g9HwzNgl/cwu4wb3uaJnd/z5X/LxfZV87pZtcQtugaTjTcg87/ZZWuVZOX1nHx+l
 jPIZDiCq+Bo32535RZ7vhyxxqx3tK2RY1IYIrnqvZhJ5PFtpk4FZ3+F7wg+eXLKKbWupsPmqQ
 9cbgqG2FD9LHClm0goSw3ZJp68cGEqpHk37lWKnsFyhvUb+l7foyd+WIirz7fYiPk6iZAIB08
 Q0Ej7E6h3YC3JHwAXIe5GNEbLtXoXb1TrH0PUbV4c5PdamRb+I2DDNe2cuY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.19 12:42, Li, Aubrey wrote:
> 
> Yep, I'll make it disabled by default and not switchable and let arch select it.
> 

That's not quite what I've suggested. Instead:

#1: make the switch depend on the arch's that support it
#2: still leave it selectable to the user, so somebody who doesn't need
    it, can just disable it.

(I, personally, tend to disable everything I don't need)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
