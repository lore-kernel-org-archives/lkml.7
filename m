Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DEDC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E838820700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="cftZd01d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfJCPK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:10:27 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:19070 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfJCPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:10:26 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93F9ql2007306;
        Thu, 3 Oct 2019 16:10:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=aiiwgq017sgikgeS8nK7Pvr05rJOP3xAjs885pxUnCY=;
 b=cftZd01dUaoyIoUMQlgPZyMIev4b2LftOiJlf+D0frzLAsRB+kIRmvtDo25DioNtjLi2
 /heMKOPbEnETw3CfzSwszbZGXJ9kq3WL02j++S4S4bmiAnj77w+YPNGOx/uSDq1TcR72
 B7XLNgfsdxhmYtyuc8M6hIYiMookcht5zHihMoCvlz/h7WpITjA2iQHIhxf+RsNKfTqw
 nPLfsfdhH1HawLMuNOuhqJ4Vyx87zUTCp+yQFYRNoOgRLvAkUromz49BOeIeeM0KxIJv
 RDaQRpPmjvTj9z8x9/GSEb02nTrHyBciTe+qoTQgAvy0fWbVq4mox/lhs66oieZOZreT Jg== 
Received: from prod-mail-ppoint7 (prod-mail-ppoint7.akamai.com [96.6.114.121] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2vceft0bws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 16:10:22 +0100
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x93F77k0021988;
        Thu, 3 Oct 2019 11:10:21 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.31])
        by prod-mail-ppoint7.akamai.com with ESMTP id 2va2v172m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 11:10:18 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) by
 usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Thu, 3 Oct 2019 11:10:02 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) by
 usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) with mapi id
 15.00.1473.005; Thu, 3 Oct 2019 11:10:02 -0400
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Greg KH <greg@kroah.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
Subject: RE: Patch "perf ftrace: Use CAP_SYS_ADMIN instead of euid==0" has
 been added to the 5.3-stable tree
Thread-Topic: Patch "perf ftrace: Use CAP_SYS_ADMIN instead of euid==0" has
 been added to the 5.3-stable tree
Thread-Index: AQHVeHvlnnYd4NteX0ObrI+M1hArMKdI0G4AgAAyjIA=
Date:   Thu, 3 Oct 2019 15:10:02 +0000
Message-ID: <795ba9fa06cf40048aecc60fff35e21c@usma1ex-dag1mb6.msg.corp.akamai.com>
References: <20191001171555.9CBC6205C9@mail.kernel.org>
 <20191003075006.GA1830608@kroah.com>
In-Reply-To: <20191003075006.GA1830608@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.35.174]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030141
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_06:2019-10-03,2019-10-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910030141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 3, 2019 at 3:50 AM Greg KH <greg@kroah.com> wrote:
> Sent: Thursday, October 3, 2019 3:50 AM
>=20
> On Tue, Oct 01, 2019 at 01:15:54PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> >
> >     perf ftrace: Use CAP_SYS_ADMIN instead of euid=3D=3D0
> >
> > to the 5.3-stable tree which can be found at:
> >
> > http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git=
;
> > a=3Dsummary
> >
> > The filename of the patch is:
> >      perf-ftrace-use-cap_sys_admin-instead-of-euid-0.patch
> > and it can be found in the queue-5.3 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable
> > tree, please let <stable@vger.kernel.org> know about it.
> >
> >
> >
> > commit 54a277c389061fc501624f51a13426d7b797f5f7
> > Author: Igor Lubashev <ilubashe@akamai.com>
> > Date:   Wed Aug 7 10:44:17 2019 -0400
> >
> >     perf ftrace: Use CAP_SYS_ADMIN instead of euid=3D=3D0
> >
> >     [ Upstream commit c766f3df635de14295e410c6dd5410bc416c24a0 ]
>=20
>=20
> Sasha, this patch is breaking the build of perf in the stable branches.
> Can you fix it up, or drop it?

This patch is fixing what's been broken forever in perf, so it is improving=
 perf tool.  But it is not fixing a vuln in the kernel itself.

In any case, this patch is a part of a series.  You would need the followin=
g to make that patch compile:
97993bd6eb89 perf tools: Add NO_LIBCAP=3D1 to the minimal build test
c22e150e3afa perf tools: Add helpers to use capabilities if present

Also, if you believe this update to perf tool warrants inclusion in a stabl=
e update, I'd rather point you at the entire series:

d06e5fad8c46 perf tools: Warn that perf_event_paranoid can restrict kernel =
symbols
8859aedefefe perf symbols: Use CAP_SYSLOG with kptr_restrict checks
aa97293ff129 perf evsel: Kernel profiling is disallowed only when perf_even=
t_paranoid > 1
dda1bf8ea78a perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
e9a6882f267a perf event: Check ref_reloc_sym before using it
73e5de70dca0 perf ftrace: Improve error message about capability to use ftr=
ace
c766f3df635d perf ftrace: Use CAP_SYS_ADMIN instead of euid=3D=3D0
083c1359b0e0 perf tools: Add CAP_SYSLOG define for older systems
97993bd6eb89 perf tools: Add NO_LIBCAP=3D1 to the minimal build test
c22e150e3afa perf tools: Add helpers to use capabilities if present
74d5f3d06f70 tools build: Add capability-related feature detection

Best,

- Igor
