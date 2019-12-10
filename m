Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9283C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA182073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLJADB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:03:01 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49700 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfLJADB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:03:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DBCDA609D2C3;
        Tue, 10 Dec 2019 01:02:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ni-rE7Dfg3Ju; Tue, 10 Dec 2019 01:02:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 88D1960B3027;
        Tue, 10 Dec 2019 01:02:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cDLlGxCrPFF2; Tue, 10 Dec 2019 01:02:58 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 60108609D2C3;
        Tue, 10 Dec 2019 01:02:58 +0100 (CET)
Date:   Tue, 10 Dec 2019 01:02:58 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davidgow <davidgow@google.com>
Message-ID: <1785498655.111829.1575936178298.JavaMail.zimbra@nod.at>
In-Reply-To: <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
References: <20191206020153.228283-1-brendanhiggins@google.com> <20191206020153.228283-2-brendanhiggins@google.com> <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com> <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com> <20191207012108.GA220741@google.com> <15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com> <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: drivers: remove support for UML_NET_PCAP
Thread-Index: hO49xBuZNB9UehdA0F84GK6DxT1WWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Brendan Higgins" <brendanhiggins@google.com>
>> IMHO we should at least mark them as "obsolete" and start preparing to
>> remove them.
> 
> Alright, I will send a patch out which marks the other network drivers
> as "obsolete".
> 
> Clarification: Should I mark all UML network devices as "obsolete"
> except for NET_VECTOR? Daemon and MCAST looked to me (I am not a
> networking expert), like they might not be covered by vector.

No. Why?

Thanks,
//richard
