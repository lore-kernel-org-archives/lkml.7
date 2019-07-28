Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F22AC7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 21:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595AB206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 21:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfG1VSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 17:18:01 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4643 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfG1VSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 17:18:00 -0400
X-Greylist: delayed 3687 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 17:18:00 EDT
Received: from thorin.petrovitsch.priv.at (80-110-96-12.cgn.dynamic.surfer.at [80.110.96.12])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id x6SKFaJB008567
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Sun, 28 Jul 2019 22:15:37 +0200
Subject: Re: build error
To:     Matteo Croce <mcroce@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <57eeca23-3f03-cfd2-280e-4b19eb84b65d@petrovitsch.priv.at>
Date:   Sun, 28 Jul 2019 22:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.tuxoid.at 1290; Body=4 Fuz1=4 Fuz2=4
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 28/07/2019 22:08, Matteo Croce wrote:
[...]
> I get this build error with 5.3-rc2"
> 
> # make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.

- Install (some) gcc?!
- Fix $PATH so that (some) gcc can be found?!

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
