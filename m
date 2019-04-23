Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B71C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D931E20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FX5765Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfDWIit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:38:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:38:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3N8YMCW003608;
        Tue, 23 Apr 2019 08:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=tEsn4kZu809kRTGqYobDogJ4G9e03+g7H6ipdOqD2dk=;
 b=FX5765Hc73WJE+fuyBGNDBaVJi7J7201Vy6atkwKodLPq+rrl3dhWXCZzH7NceYuJkzm
 ZdretX/3l8Xp+2/FihtHoz6vT1NYoXICeIcXXVrVucxmm63rdx0W5gzw+Nj+cj/2vM6b
 j5ajqJLHnGSSBk2UosP/N4LlMcozhZPpEb+uFRlm8xZReWhuz9HypaOwj9HBArv4dI+W
 AQVhKk0ZF3cJKPh8mAXyLtJv0gkC2Nfs6t3o/gmQAm1RIiSvbq4DFN14nrLwb/Wcb2j4
 oPAuqhl3zIDvde4dwdJuMYw/P13RZ0xJbJkG+jYNqMfmDgOvCR6iDFDI2T/uXJi0y/Mc nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rytustnpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 08:37:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3N8aiHl095379;
        Tue, 23 Apr 2019 08:37:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2s0dwe4wh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 08:37:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3N8bsqq026630;
        Tue, 23 Apr 2019 08:37:54 GMT
Received: from abi.no.oracle.com (/141.143.213.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Apr 2019 01:37:54 -0700
Message-ID: <f08575cfa7aae2c0d156ebbde75d7f6d8baefedf.camel@oracle.com>
Subject: Re: Linux Testing Microconference at LPC
From:   Knut Omang <knut.omang@oracle.com>
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk, Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Apr 2019 10:37:51 +0200
In-Reply-To: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904230062
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904230062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-04-11 at 10:37 -0700, Dhaval Giani wrote:
> Hi Folks,
> 
> This is a call for participation for the Linux Testing microconference
> at LPC this year.
> 
> For those who were at LPC last year, as the closing panel mentioned,
> testing is probably the next big push needed to improve quality. From
> getting more selftests in, to regression testing to ensure we don't
> break realtime as more of PREEMPT_RT comes in, to more stable distros,
> we need more testing around the kernel.
> 
> We have talked about different efforts around testing, such as fuzzing
> (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> testing, test frameworks such as ktests, smatch to find bugs in the
> past. We want to push this discussion further this year and are
> interested in hearing from you what you want to talk about, and where
> kernel testing needs to go next.
> 
> Please let us know what topics you believe should be a part of the
> micro conference this year.

I'd like to propose another topic on unit test framework 
support in the kernel:

From the initial reactions and interest I have seen wrt. KTF 
(http://heim.ifi.uio.no/~knuto/ktf/, https://github.com/oracle/ktf) 
and the discussions on LKML around KUnit (https://lkml.org/lkml/2018/11/29/82), 
it seems there's a general belief that some form of unit test framework 
like these can be a good addition to the tools and infrastructure already available
in the kernel.

It seems however that different people have different notions about what 
and how such a framework should ideally look, and what features belong there.
I'd like to see if we can bring that discussion forward by focusing on 
some of these items, where people seem to have quite differing views
depending on where they come from. Here is a non extensive list of 
some topics that seems to pop up when this gets discussed:

  - "Purity" of unit testing - what constitutes a "unit" in the kernel?
  - Testing kernel code - user space vs kernel space? (both useful)
  - Immediate development/debugging requirements vs longer term needs
  - Driver/hardware interaction testing?
  - "Neat"-factor
  - ease of use
  - Network testing (more than 1 kernel involved)
  ...

I'd like to make a short intro into this, and hopefully we can have some 
good exchange based on that. 

[While our contribution (KTF) is currently available on Github, 
at that point in time I plan for us to have submitted a version 
of it to the LKML as well]

Thanks,
Knut

