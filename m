Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07023C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C3D218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfDXMaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:30:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbfDXMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:30:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OCTdP6125006
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:30:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s2mwy10kt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:30:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 24 Apr 2019 13:30:09 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 13:30:05 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OCU4Vl50397410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 12:30:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA8F1AE051;
        Wed, 24 Apr 2019 12:30:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B439AE058;
        Wed, 24 Apr 2019 12:30:03 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Apr 2019 12:30:03 +0000 (GMT)
Date:   Wed, 24 Apr 2019 14:30:02 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 31/79] docs: s390: convert docs to ReST and rename to
 *.rst
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
 <20190424134109.2891a7cc.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424134109.2891a7cc.cohuck@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19042412-0012-0000-0000-000003130BC3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042412-0013-0000-0000-0000214B6108
Message-Id: <20190424123001.GB3990@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 01:41:09PM +0200, Cornelia Huck wrote:
> > diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/debugging390.rst
> > similarity index 53%
> > rename from Documentation/s390/Debugging390.txt
> > rename to Documentation/s390/debugging390.rst
> > index c35804c238ad..d49305fd5e1a 100644
> > --- a/Documentation/s390/Debugging390.txt
> > +++ b/Documentation/s390/debugging390.rst
> 
> I'll skip this one...
> 
> (Question for the s390 arch maintainers: I remember that there was some
> interesting stuff in there, but I'm not sure how much of it is still
> accurate/useful... is it worth spending time on trying to update this?)
> 
> > diff --git a/Documentation/s390/text_files.rst b/Documentation/s390/text_files.rst
> > new file mode 100644
> > index 000000000000..c94d05d4fa17
> > --- /dev/null
> > +++ b/Documentation/s390/text_files.rst
> > @@ -0,0 +1,11 @@
> > +ibm 3270 changelog
> > +------------------
> > +
> > +.. include:: 3270.ChangeLog
> > +    :literal:
> > +
> > +ibm 3270 config3270.sh
> > +----------------------
> > +
> > +.. literalinclude:: config3270.sh
> > +    :language: shell
> 
> 
> Another question for the s390 arch maintainers: How valuable is this still?

...to be honest I consider 80% within Documentation/s390 to be
completely outdated, partially wrong, or irrelevant in the meantime;
the vfio stuff seems to be pretty much up-to-date, and I like the
parts that move comments to code.

Cleaning this up can be done at a later time. I don't want to make
Mauro spend more time than necessary on this.

