Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA0221721
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbfGOWFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:05:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731717AbfGOWFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:05:41 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FLwjbc073885
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:05:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trxmdfxbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:05:40 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 15 Jul 2019 23:05:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 23:05:34 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FM5XAa48103650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 22:05:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BAE142045;
        Mon, 15 Jul 2019 22:05:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B3034204C;
        Mon, 15 Jul 2019 22:05:32 +0000 (GMT)
Received: from localhost (unknown [9.145.71.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Jul 2019 22:05:32 +0000 (GMT)
Date:   Tue, 16 Jul 2019 00:05:30 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Petr Tesarik <PTesarik@suse.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Raymund Will <rw@suse.com>
Subject: Re: [PATCH 2/2] s390: add Linux banner to the compressed image
References: <cover.1562950641.git.ptesarik@suse.com>
 <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
 <your-ad-here.call-01563114933-ext-9422@work.hours>
 <20190714175041.194c98be@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190714175041.194c98be@ezekiel.suse.cz>
X-TM-AS-GCONF: 00
x-cbid: 19071522-0008-0000-0000-000002FD7B28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071522-0009-0000-0000-0000226AEED9
Message-Id: <your-ad-here.call-01563228330-ext-8076@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 03:52:52PM +0000, Petr Tesarik wrote:
> On Sun, 14 Jul 2019 16:35:33 +0200
> Vasily Gorbik <gor@linux.ibm.com> wrote:
> 
> > On Fri, Jul 12, 2019 at 07:21:01PM +0200, Petr Tesarik wrote:
> > > Various tools determine the kernel version from a given binary by
> > > scanning for the Linux banner string. This does not work if the
> > > banner string is compressed, but we can link it once more into the
> > > uncompressed portion of bzImage.
> 
> > But even before discussing solutions I would like to understand the
> > problem first. Which specific tools are you referring to? What are they
> > good for? And how do they get the kernel version from other architectures
> > compressed images?
> 
> The tool I'm aware of is called get_kernel_version. It's built as part
> of openSUSE aaa_base and is used at install time. I'm not quite sure
> how it is used, but I have added Raymund Will to Cc; he can provide
> more information. There's also an open bug for it:
> 
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1139939

Oh, I see, found it, thanks. Very interesting tool.
https://github.com/openSUSE/aaa_base/blob/master/get_kernel_version.c

And the only usage of this tool I found is to get the kernel version of
/boot/image (on s390) to run depmod during
yast-installation/src/clients/network_finish.rb

I also see that queries to rpm are already done from
yast-yast2/library/system/src/modules/Kernel.rb
Wouldn't it be more reliable (and portable) to just get the kernel
version from rpm metadata? Without using unreliable tools? Or find some
other solution, since this is the only use case for the tool?
$ rpm -qf --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' /boot/vmlinuz-5.1.17-300.fc30.x86_64
5.1.17-300.fc30.x86_64
[it looks like openSUSE kernel rpms don't have metadata to reconstruct
full kernel version currently, but that could be improved?]

Anyhow, I'm not opposed to an idea to make it possible to detect the
kernel version from bzImage. But it should be reliable. So, see the
follow on patch I'm sending.

