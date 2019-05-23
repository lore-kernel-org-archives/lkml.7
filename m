Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A16C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F1620881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIHKKZsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfEWE4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 00:56:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47472 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfEWEz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 00:55:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4N4s0Go127686;
        Thu, 23 May 2019 04:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=ooMrGUiacDK2usXLFuP0Ry1RM2zAp7bE+Dq757PMP/c=;
 b=HIHKKZsN7fLekpt3hXT+qLn8EPmE0cYKHFLCCjTc+VLOPz+jS+YViLIPgPJba6pWgqmJ
 2DxIolUv5kvyT7C4s6b05u+Zc8IFbrAeG6tunoAkhb8KPoiv8DIuzHJ+4OHZldq4FsSI
 zYi8WnErHNgxjD/h5i+2E9llgIT5/A9rbIV6zIWfljEVsEEEbcSPl1jJ8wJqp9mv/iTt
 +V4I6Q2xO19ZeUPTR/DkbIOUks8WqkDVoW5WB8YK+Mcf5iKtPm1r79WNkB2//r5ro5AL
 CoVFzNKGALJEtYlJi13Eu2VlaLJwVyZsENnVSSUil1r5qbus0VhCO+s6zflqY/RSNx5k Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2smsk57u7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 04:55:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4N4sD8F196187;
        Thu, 23 May 2019 04:55:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2smsh2110w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 04:55:08 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4N4t2EO011406;
        Thu, 23 May 2019 04:55:02 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 May 2019 04:55:02 +0000
Message-ID: <44957d4eccc4df68036ad44cbe9b16778191f47d.camel@oracle.com>
Subject: Re: Linux Testing Microconference at LPC
From:   Knut Omang <knut.omang@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     shuah <shuah@kernel.org>, Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk, Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 May 2019 06:54:57 +0200
In-Reply-To: <20190522210231.GA212436@google.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
         <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
         <20190516003649.GS11972@sasha-vm> <20190522210231.GA212436@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905230034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905230034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 14:02 -0700, Brendan Higgins wrote:
> On Wed, May 15, 2019 at 08:36:49PM -0400, Sasha Levin wrote:
> > On Wed, May 15, 2019 at 04:44:19PM -0600, shuah wrote:
> > > Hi Sasha and Dhaval,
> > > 
> > > On 4/11/19 11:37 AM, Dhaval Giani wrote:
> > > > Hi Folks,
> > > > 
> > > > This is a call for participation for the Linux Testing microconference
> > > > at LPC this year.
> > > > 
> > > > For those who were at LPC last year, as the closing panel mentioned,
> > > > testing is probably the next big push needed to improve quality. From
> > > > getting more selftests in, to regression testing to ensure we don't
> > > > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > > > we need more testing around the kernel.
> > > > 
> > > > We have talked about different efforts around testing, such as fuzzing
> > > > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > > > testing, test frameworks such as ktests, smatch to find bugs in the
> > > > past. We want to push this discussion further this year and are
> > > > interested in hearing from you what you want to talk about, and where
> > > > kernel testing needs to go next.
> > > > 
> > > > Please let us know what topics you believe should be a part of the
> > > > micro conference this year.
> > > > 
> > > > Thanks!
> > > > Sasha and Dhaval
> > > > 
> > > 
> > > A talk on KUnit from Brendan Higgins will be good addition to this
> > > Micro-conference. I am cc'ing Brendan on this thread.
> > > 
> > > Please consider adding it.
> > 
> > FWIW, the topic of unit tests is already on the schedule. There seems to
> > be two different sub-topics here (kunit vs KTF) so there's a good
> > discussion to be had here on many levels.
> 
> Cool, so do we just want to go with that? Have a single slot for KUnit
> and KTF combined?
> 
> We can each present our work up to this point; maybe offer some
> background and rationale on why we made the decision we have and then we
> can have some moderated discussion on, pros, cons, next steps, etc?

I definitely had KTF and KUnit in mind when proposing this topic.
If you recall from the last time we discussed unit testing, each slot is 
fairly limited in time. My plan for the intro for discussion is to 
itemize some of the distinct goals we try to achieve with our frameworks and have a
discussion based on that. In light of the discussion around your patch sets,
one topic is also the question of whether a common API would be useful/desired, 
and whether we can "capture" a short namespace for that.

Thanks,
Knut

> Cheers

