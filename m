Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FA3C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213452075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfHFTCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:02:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfHFTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:02:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76J2ItQ128790
        for <linux-kernel@vger.kernel.org>; Tue, 6 Aug 2019 15:02:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7e24u49x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:02:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 6 Aug 2019 20:02:22 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Aug 2019 20:02:19 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x76J2IPi46530734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 19:02:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53060A404D;
        Tue,  6 Aug 2019 19:02:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B06CA4051;
        Tue,  6 Aug 2019 19:02:17 +0000 (GMT)
Received: from dhcp-9-31-103-47.watson.ibm.com (unknown [9.31.103.47])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 19:02:17 +0000 (GMT)
Subject: Re: linux-next: build failure after merge of the integrity tree
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Date:   Tue, 06 Aug 2019 15:02:16 -0400
In-Reply-To: <20190806134530.747d155e@canb.auug.org.au>
References: <20190806121519.0f8ac653@canb.auug.org.au>
         <87imrb0yoh.fsf@morokweng.localdomain>
         <20190806134530.747d155e@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080619-0008-0000-0000-00000305E60D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080619-0009-0000-0000-0000A17FF045
Message-Id: <1565118136.11223.215.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 2019-08-06 at 13:45 +1000, Stephen Rothwell wrote:
> Hi Thiago,
> 
> On Tue, 06 Aug 2019 00:18:06 -0300 Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
> >
> > Sorry for the trouble. I wasn't aware of that build time check.
> > I'll enable HEADER_TEST and KERNEL_HEADER_TEST for my next patches.

ditto

> 
> I do allmodconfig builds which enable those.
> 
> > Thanks for providing the fix. Should I post a new version or can Mimi
> > squash the above into the original patch?
> 
> Up to Mimi, but either works (or just committing my patch if the tree is
> normally not rebased).

Based on the new "Documentation/maintainer/rebasing-and-merging.rst",
I'm under the impression that we shouldn't be rebasing, even for
"just" adding tags.  Waiting for tags before pushing out to next-
integrity is causing delays, but we're trying out this approach.  So
for now, I've included your commit.

thanks,

Mimi



