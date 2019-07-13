Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C8C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981F12083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGMOpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:45:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfGMOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:45:39 -0400
Received: from [192.168.1.110] ([95.114.35.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mj8eB-1iQbog1GDt-00fDUT; Sat, 13 Jul 2019 16:44:15 +0200
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
References: <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de> <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <40f70582-c16a-7de0-cfd6-c7d5ff9ead71@metux.net>
 <20190703173555.GW19023@42.do-not-panic.com>
 <9a2ae341-9ea7-d4c6-7c3e-b12bb6515905@metux.net>
 <20190703224234.GY19023@42.do-not-panic.com>
 <CAFd5g454UVYqm+HgA1nXsy-cAg_3gvjvZ4KQmW4P5gqpDp1WMg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <b0b572e3-5d08-2224-fd8b-07f6bcbed53e@metux.net>
Date:   Sat, 13 Jul 2019 16:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g454UVYqm+HgA1nXsy-cAg_3gvjvZ4KQmW4P5gqpDp1WMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u6wYlfGnjnkR3Xeu+hRhHdqLjaS/GGfjUkpndOTSA1mBCdpVC73
 mRrCMUZUY9C2Z6J1WvARitz5E8/iLDCz+LzA8ElU/xka1lOGVj7wzLSjwkcJLD45BP+T7WP
 S2YnelCyiDSj3ThDJ3MUb4E2gWNWEfM0UudkWLkh3mpqja+Oc27rFfl/SdScv7OljX1q8dg
 ZJmHp6hl89LqXZNBAZ3YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TYXxZbEE+oA=:ZH+2P0kZStamGcfTyjisxE
 bVMF5lqguB3ar4woifb+YE7ZDexRVVzccIW+cza/359VRzVUTcrRY9GEO6iLxZxlEU7BfDZEI
 BZfUpNGniUDgC8bbm32Ro05TjLGH6hkDpKD7VDAEHuARguTgtEKahw2GNKlXeqbW1RBxMILVb
 nLqFDzI6f6PU+b8861kR+ZTKqlPoJyVeNCHWN8Q+l/pRykVFzyaBnzUYT12Txh+MV8HstY2NC
 A/6KbrBl63Eq+qKcCys9B+lWp0emkdfAGkZ8GEimEu6KJpG068w7ePCCKcY0raxHoRh2XcKXR
 Oecai/zitwl81GBSPCWUURSIrBWf0uUHHLeo2koeVbOxmZpgfh8Rv4m65RC7Fp7er8n/3T09H
 j+RzObrlWfX6t++MfZC5Y1XQFmaiaRrNlhy7XTNm7oVYbZeTb5/jHKSZJzQGtpbmpmn2/whF1
 S3JL8RSVjz2fQYoG9jO1PUFZQO8sq/Q74aa8XXbRRac4tRf3mSe9FZZKUfUPzNSwQGld9uGQp
 iWI4+aFi7CER9tUHcKD6JLPZ1gSXnn2lzdZ/1OnmvuwXRl3BR9CBMMmT59AW3psa33mDm0zhK
 mcXUrEcsoaYUqmhRSi5rhc2BtgG2hb4Iwnc8v9N19PoxKa6Keb2tamYXsCIUQIfFGUVt1+mQ+
 Cu7j7VIpq9RFfoXyzSHEHkMFMSZjmWMaXysqYTu2ujdY9RPM5F/wZZuYfMF3w7FdSfLGxCKAS
 62X0jJrPsCKMcTfNBiF+Oz43SkuMC6oy1mme2Ic5XKY/RVz40nmZDEOgRps=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.19 01:27, Brendan Higgins wrote:

> Enrico, want me to CC you on that> and we can continue this discussion there?
Yes. But I'd prefer having an own list for it - better for sorting and
archiving ;-)

> I wonder if that would work for the testing scenario? I don't think it> is unreasonable for a test owner to provide a defconfig that makes it>
possible to run their test. We could then merge these together to>
create a kconfig to run all desired tests. Doesn't address all the>
issues I mentioned here, but it's a start.
defconfig is a different thing - my idea (that I've dropped) was
actually introducing new config options per board (and sub options
for board features) which switch on all the neccessary things.

The defconfigs are nice thing for starting off with some board, but
they're basically examples, not production configurations. Yet another
point why I've decided to cope all of this in a separate tool.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
