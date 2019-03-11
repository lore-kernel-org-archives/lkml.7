Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67182C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4F120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCKLtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:49:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727213AbfCKLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:49:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BBnJQW039729
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:49:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5nxj2syt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:49:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 11 Mar 2019 11:49:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 11:49:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BBnUdI46137390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 11:49:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 703784C040;
        Mon, 11 Mar 2019 11:49:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8311E4C044;
        Mon, 11 Mar 2019 11:49:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.170])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 11:49:29 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] selftests/ima: kexec_file_load syscall test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Mar 2019 07:49:18 -0400
In-Reply-To: <20190311083417.GA13067@x230>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
         <1551223620-11586-5-git-send-email-zohar@linux.ibm.com>
         <20190228220039.GC20335@dell5510> <1552240104.5062.10.camel@linux.ibm.com>
         <20190311083417.GA13067@x230>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031111-4275-0000-0000-000003199877
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031111-4276-0000-0000-00003827FCB0
Message-Id: <1552304958.6100.28.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=855 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 09:34 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > On Thu, 2019-02-28 at 23:00 +0100, Petr Vorel wrote:
> 
> > > > +	local keypair1="$2"
> > > > +	local keypair2="$3"
> > > > +
> > > > +	mount_securityfs
> > > > +
> > > > +	local ima_policy=$SECURITYFS/ima/policy
> > > > +	if [ ! -e $ima_policy ]; then
> > > > +		log_fail "$ima_policy not found"
> > > > +	fi
> > > > +
> > > > +	if [ -n $keypair2 ]; then
> > > > +		grep -e "^$action.*$keypair1" "$ima_policy" | \
> > > > +			grep -q -e "$keypair2"
> > > > +	else
> > > > +		grep -q -e "^$action.*$keypair1" "$ima_policy"
> > > > +	fi
> > > > +
> > > > +	[ $? -eq 0 ] && ret=1 || ret=0
> > > > +        return $ret
> > > return $? is enough here (+ ret was not defined as local and
> mixing tabs with spaces)
> 
> > "grep -q" exits with zero if any match is found.  This line inverts
> > the result so that 1 is returned for found.
> Right. Sorry for wrong report :).

Thank you so much for reviewing the patches!  Other than deferring
making the IMA "common" functions generic, hopefully I didn't miss
anything.  I just posted the v3 version.

Mimi

> >  v3 will make "ret" local and fix the tabs/spaces.
> 
> 
> Kind regards,
> Petr
> 

